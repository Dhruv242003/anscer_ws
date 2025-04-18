cmake_minimum_required(VERSION 3.0.2)
project(trajectory_visualizer)

find_package(catkin REQUIRED COMPONENTS
  nav_msgs
  roscpp
  rospy
  std_msgs
  tf2
  visualization_msgs
  tf2_ros
  tf2_geometry_msgs

)

add_service_files(FILES SaveTrajectory.srv)
generate_messages(DEPENDENCIES std_msgs)

catkin_package()


include_directories(
  ${catkin_INCLUDE_DIRS}
)

add_executable(trajectory_publisher src/trajectory_publisher.cpp)
target_link_libraries(trajectory_publisher ${catkin_LIBRARIES})

add_executable(trajectory_saver src/trajectory_saver.cpp)
add_executable(trajectory_reader_publisher src/trajectory_reader_publisher.cpp)
target_link_libraries(trajectory_saver ${catkin_LIBRARIES})
target_link_libraries(trajectory_reader_publisher ${catkin_LIBRARIES})

