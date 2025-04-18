#include <ros/ros.h>
#include <visualization_msgs/MarkerArray.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <deque>

std::deque<geometry_msgs::PoseStamped> trajectory;
ros::Publisher marker_pub;

void poseCallback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& msg) {
    geometry_msgs::PoseStamped poseStamped;
    poseStamped.header = msg->header;
    poseStamped.pose = msg->pose.pose;

    ROS_INFO("Received /amcl_pose: x=%.2f, y=%.2f, z=%.2f", 
             poseStamped.pose.position.x, 
             poseStamped.pose.position.y, 
             poseStamped.pose.position.z);

    trajectory.push_back(poseStamped);

    double current_time = poseStamped.header.stamp.toSec();
    while (!trajectory.empty() && (current_time - trajectory.front().header.stamp.toSec()) > 20.0) {
        trajectory.pop_front();
    }

    
    visualization_msgs::MarkerArray marker_array;
    int id = 0;
    for (const auto& pose : trajectory) {
        visualization_msgs::Marker marker;
        marker.header.frame_id = "map";
        marker.header.stamp = ros::Time::now();
        marker.ns = "trajectory";
        marker.id = id++;
        marker.type = visualization_msgs::Marker::SPHERE;
        marker.action = visualization_msgs::Marker::ADD;
        marker.pose = pose.pose;
        marker.scale.x = 0.1;
        marker.scale.y = 0.1;
        marker.scale.z = 0.1;
        marker.color.a = 1.0;
        marker.color.r = 1.0;
        marker.color.g = 0.0;
        marker.color.b = 0.0;

        marker_array.markers.push_back(marker);
    }

    marker_pub.publish(marker_array);
    ROS_INFO("Published %lu markers", marker_array.markers.size());
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "trajectory_publisher");
    ros::NodeHandle nh;

    marker_pub = nh.advertise<visualization_msgs::MarkerArray>("trajectory_markers", 10);
    ros::Subscriber pose_sub = nh.subscribe("/amcl_pose", 100, poseCallback);

    ros::spin();
}
