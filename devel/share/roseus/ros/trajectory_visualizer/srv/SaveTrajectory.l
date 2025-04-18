;; Auto-generated. Do not edit!


(when (boundp 'trajectory_visualizer::SaveTrajectory)
  (if (not (find-package "TRAJECTORY_VISUALIZER"))
    (make-package "TRAJECTORY_VISUALIZER"))
  (shadow 'SaveTrajectory (find-package "TRAJECTORY_VISUALIZER")))
(unless (find-package "TRAJECTORY_VISUALIZER::SAVETRAJECTORY")
  (make-package "TRAJECTORY_VISUALIZER::SAVETRAJECTORY"))
(unless (find-package "TRAJECTORY_VISUALIZER::SAVETRAJECTORYREQUEST")
  (make-package "TRAJECTORY_VISUALIZER::SAVETRAJECTORYREQUEST"))
(unless (find-package "TRAJECTORY_VISUALIZER::SAVETRAJECTORYRESPONSE")
  (make-package "TRAJECTORY_VISUALIZER::SAVETRAJECTORYRESPONSE"))

(in-package "ROS")





(defclass trajectory_visualizer::SaveTrajectoryRequest
  :super ros::object
  :slots (_filename _duration ))

(defmethod trajectory_visualizer::SaveTrajectoryRequest
  (:init
   (&key
    ((:filename __filename) "")
    ((:duration __duration) 0.0)
    )
   (send-super :init)
   (setq _filename (string __filename))
   (setq _duration (float __duration))
   self)
  (:filename
   (&optional __filename)
   (if __filename (setq _filename __filename)) _filename)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:serialization-length
   ()
   (+
    ;; string _filename
    4 (length _filename)
    ;; float32 _duration
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _filename
       (write-long (length _filename) s) (princ _filename s)
     ;; float32 _duration
       (sys::poke _duration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _filename
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _filename (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _duration
     (setq _duration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass trajectory_visualizer::SaveTrajectoryResponse
  :super ros::object
  :slots (_success _message ))

(defmethod trajectory_visualizer::SaveTrajectoryResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass trajectory_visualizer::SaveTrajectory
  :super ros::object
  :slots ())

(setf (get trajectory_visualizer::SaveTrajectory :md5sum-) "1627d748845e26865bbe2f4eb092df90")
(setf (get trajectory_visualizer::SaveTrajectory :datatype-) "trajectory_visualizer/SaveTrajectory")
(setf (get trajectory_visualizer::SaveTrajectory :request) trajectory_visualizer::SaveTrajectoryRequest)
(setf (get trajectory_visualizer::SaveTrajectory :response) trajectory_visualizer::SaveTrajectoryResponse)

(defmethod trajectory_visualizer::SaveTrajectoryRequest
  (:response () (instance trajectory_visualizer::SaveTrajectoryResponse :init)))

(setf (get trajectory_visualizer::SaveTrajectoryRequest :md5sum-) "1627d748845e26865bbe2f4eb092df90")
(setf (get trajectory_visualizer::SaveTrajectoryRequest :datatype-) "trajectory_visualizer/SaveTrajectoryRequest")
(setf (get trajectory_visualizer::SaveTrajectoryRequest :definition-)
      "string filename
float32 duration
---
bool success
string message


")

(setf (get trajectory_visualizer::SaveTrajectoryResponse :md5sum-) "1627d748845e26865bbe2f4eb092df90")
(setf (get trajectory_visualizer::SaveTrajectoryResponse :datatype-) "trajectory_visualizer/SaveTrajectoryResponse")
(setf (get trajectory_visualizer::SaveTrajectoryResponse :definition-)
      "string filename
float32 duration
---
bool success
string message


")



(provide :trajectory_visualizer/SaveTrajectory "1627d748845e26865bbe2f4eb092df90")


