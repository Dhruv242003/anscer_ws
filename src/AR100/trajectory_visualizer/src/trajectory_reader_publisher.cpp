#include <ros/ros.h>
#include <visualization_msgs/MarkerArray.h>
#include <visualization_msgs/Marker.h>
#include <nav_msgs/Path.h>
#include <geometry_msgs/PoseStamped.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <fstream>
#include <sstream>
#include <string>

class TrajectoryReaderPublisher
{
public:
    TrajectoryReaderPublisher(ros::NodeHandle& nh)
    {
        // Fetch parameters
        nh.param("file_path", file_path_, std::string("/home/dhruv/anscer_ws/src/AR100/trajectory_visualizer/trajectories/"));

        marker_pub_ = nh.advertise<visualization_msgs::MarkerArray>("transformed_trajectory_markers", 10);
        path_pub_ = nh.advertise<nav_msgs::Path>("transformed_trajectory_path", 10);
    }

    void publishTrajectory(const std::string& file_name, tf2_ros::Buffer& tf_buffer)
    {
        std::ifstream file(file_path_ + file_name);
        if (!file.is_open())
        {
            ROS_ERROR("Could not open trajectory file: %s", file_name.c_str());
            return;
        }

        visualization_msgs::MarkerArray marker_array;
        nav_msgs::Path path_msg;
        path_msg.header.frame_id = "odom";
        path_msg.header.stamp = ros::Time::now();

        std::string line;
        int id = 0;

        while (std::getline(file, line))
        {
            std::stringstream ss(line);
            double timestamp, x, y, z;
            if (!(ss >> timestamp >> x >> y >> z))
            {
                ROS_WARN("Skipping invalid line in file: %s", line.c_str());
                continue;
            }

            
            geometry_msgs::PoseStamped pose_stamped;
            pose_stamped.header.frame_id = "map";  
            pose_stamped.header.stamp = ros::Time(timestamp);
            pose_stamped.pose.position.x = x;
            pose_stamped.pose.position.y = y;
            pose_stamped.pose.position.z = z;
            pose_stamped.pose.orientation.w = 1.0;  

            
            try {
                geometry_msgs::TransformStamped transform_stamped = tf_buffer.lookupTransform("odom", "map", ros::Time(0), ros::Duration(1.0));
                tf2::doTransform(pose_stamped, pose_stamped, transform_stamped);
            } catch (tf2::TransformException& ex) {
                ROS_WARN("Could not transform trajectory point: %s", ex.what());
                continue;
            }

            
            visualization_msgs::Marker marker;
            marker.header.frame_id = "odom";
            marker.header.stamp = ros::Time::now();
            marker.ns = "transformed_trajectory";
            marker.id = id++;
            marker.type = visualization_msgs::Marker::SPHERE;
            marker.action = visualization_msgs::Marker::ADD;
            marker.pose = pose_stamped.pose;
            marker.scale.x = 0.1;
            marker.scale.y = 0.1;
            marker.scale.z = 0.1;
            marker.color.a = 1.0;
            marker.color.r = 0.0;
            marker.color.g = 1.0;  
            marker.color.b = 0.0;
            marker_array.markers.push_back(marker);

            
            path_msg.poses.push_back(pose_stamped);
        }

        file.close();
        marker_pub_.publish(marker_array);
        path_pub_.publish(path_msg);
        ROS_INFO("Transformed trajectory published!");
    }

private:
    ros::Publisher marker_pub_;
    ros::Publisher path_pub_;
    std::string file_path_;
};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "trajectory_reader_publisher");
    ros::NodeHandle nh;

    if (argc < 2)
    {
        ROS_ERROR("Usage: rosrun trajectory_visualizer trajectory_reader_publisher <file_name>");
        return 1;
    }

    std::string file_name = argv[1];

    TrajectoryReaderPublisher readerPublisher(nh);

    tf2_ros::Buffer tf_buffer;
    tf2_ros::TransformListener tf_listener(tf_buffer);

    ros::Rate loop_rate(1);
    
    while (ros::ok())
    {
        readerPublisher.publishTrajectory(file_name, tf_buffer);
        ros::spinOnce();    
        loop_rate.sleep();
    }

    return 0;
}
