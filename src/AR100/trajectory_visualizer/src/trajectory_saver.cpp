#include <ros/ros.h>
#include <visualization_msgs/MarkerArray.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <fstream>
#include <deque>
#include <string>
#include "trajectory_visualizer/SaveTrajectory.h"

class TrajectorySaver
{
public:
    TrajectorySaver(ros::NodeHandle& nh)
    {
        // Fetch parameters
        nh.param("file_path", file_path_, std::string("/home/dhruv/anscer_ws/src/AR100/trajectory_visualizer/trajectories/"));

        marker_pub_ = nh.advertise<visualization_msgs::MarkerArray>("trajectory_markers", 10);
        pose_sub_ = nh.subscribe("/amcl_pose", 100, &TrajectorySaver::poseCallback, this);
        save_service_ = nh.advertiseService("save_trajectory", &TrajectorySaver::saveTrajectory, this);
    }

    void poseCallback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& msg)
    {
        trajectory_.push_back(*msg);
        
        
        visualization_msgs::MarkerArray marker_array;
        int id = 0;
        for (const auto& pose : trajectory_)
        {
            visualization_msgs::Marker marker;
            marker.header.frame_id = "map";
            marker.header.stamp = ros::Time::now();
            marker.ns = "trajectory";
            marker.id = id++;
            marker.type = visualization_msgs::Marker::SPHERE;
            marker.action = visualization_msgs::Marker::ADD;
            marker.pose.position = pose.pose.pose.position;
            marker.scale.x = 0.1;
            marker.scale.y = 0.1;
            marker.scale.z = 0.1;
            marker.color.a = 1.0;
            marker.color.r = 1.0;
            marker.color.g = 0.0;
            marker.color.b = 0.0;
            marker_array.markers.push_back(marker);
        }
        marker_pub_.publish(marker_array);
    }

    bool saveTrajectory(trajectory_visualizer::SaveTrajectory::Request &req,
                        trajectory_visualizer::SaveTrajectory::Response &res)
    {
        double current_time = ros::Time::now().toSec();
        double requested_duration = req.duration;

        
        if (trajectory_.empty() || (current_time - trajectory_.front().header.stamp.toSec()) < requested_duration)
        {
            res.success = false;
            res.message = "Not enough data collected yet. Try again later.";
            ROS_WARN("%s", res.message.c_str());
            return false;
        }

        while (!trajectory_.empty() && (current_time - trajectory_.front().header.stamp.toSec()) > requested_duration)
        {
            trajectory_.pop_front();
        }

        std::ofstream file(file_path_ + req.filename);
        if (!file.is_open())
        {
            res.success = false;
            res.message = "Could not open file to save trajectory!";
            ROS_ERROR("%s", res.message.c_str());
            return false;
        }

        for (const auto &pose : trajectory_)
        {
            file << pose.header.stamp.toSec() << " "
                 << pose.pose.pose.position.x << " "
                 << pose.pose.pose.position.y << " "
                 << pose.pose.pose.position.z << "\n";
        }
        file.close();

        res.success = true;
        res.message = "Trajectory saved successfully.";
        ROS_INFO("%s", res.message.c_str());
        return true;
    }

private:
    ros::Publisher marker_pub_;
    ros::Subscriber pose_sub_;
    ros::ServiceServer save_service_;
    std::deque<geometry_msgs::PoseWithCovarianceStamped> trajectory_;
    std::string file_path_;
};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "trajectory_saver");
    ros::NodeHandle nh;

    TrajectorySaver trajectorySaver(nh);

    ros::spin();
    return 0;
}
