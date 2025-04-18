; Auto-generated. Do not edit!


(cl:in-package trajectory_visualizer-srv)


;//! \htmlinclude SaveTrajectory-request.msg.html

(cl:defclass <SaveTrajectory-request> (roslisp-msg-protocol:ros-message)
  ((filename
    :reader filename
    :initarg :filename
    :type cl:string
    :initform "")
   (duration
    :reader duration
    :initarg :duration
    :type cl:float
    :initform 0.0))
)

(cl:defclass SaveTrajectory-request (<SaveTrajectory-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveTrajectory-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveTrajectory-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name trajectory_visualizer-srv:<SaveTrajectory-request> is deprecated: use trajectory_visualizer-srv:SaveTrajectory-request instead.")))

(cl:ensure-generic-function 'filename-val :lambda-list '(m))
(cl:defmethod filename-val ((m <SaveTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader trajectory_visualizer-srv:filename-val is deprecated.  Use trajectory_visualizer-srv:filename instead.")
  (filename m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <SaveTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader trajectory_visualizer-srv:duration-val is deprecated.  Use trajectory_visualizer-srv:duration instead.")
  (duration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveTrajectory-request>) ostream)
  "Serializes a message object of type '<SaveTrajectory-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'filename))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'filename))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'duration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveTrajectory-request>) istream)
  "Deserializes a message object of type '<SaveTrajectory-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'filename) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'filename) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'duration) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveTrajectory-request>)))
  "Returns string type for a service object of type '<SaveTrajectory-request>"
  "trajectory_visualizer/SaveTrajectoryRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveTrajectory-request)))
  "Returns string type for a service object of type 'SaveTrajectory-request"
  "trajectory_visualizer/SaveTrajectoryRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveTrajectory-request>)))
  "Returns md5sum for a message object of type '<SaveTrajectory-request>"
  "1627d748845e26865bbe2f4eb092df90")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveTrajectory-request)))
  "Returns md5sum for a message object of type 'SaveTrajectory-request"
  "1627d748845e26865bbe2f4eb092df90")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveTrajectory-request>)))
  "Returns full string definition for message of type '<SaveTrajectory-request>"
  (cl:format cl:nil "string filename~%float32 duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveTrajectory-request)))
  "Returns full string definition for message of type 'SaveTrajectory-request"
  (cl:format cl:nil "string filename~%float32 duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveTrajectory-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'filename))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveTrajectory-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveTrajectory-request
    (cl:cons ':filename (filename msg))
    (cl:cons ':duration (duration msg))
))
;//! \htmlinclude SaveTrajectory-response.msg.html

(cl:defclass <SaveTrajectory-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass SaveTrajectory-response (<SaveTrajectory-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveTrajectory-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveTrajectory-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name trajectory_visualizer-srv:<SaveTrajectory-response> is deprecated: use trajectory_visualizer-srv:SaveTrajectory-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SaveTrajectory-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader trajectory_visualizer-srv:success-val is deprecated.  Use trajectory_visualizer-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SaveTrajectory-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader trajectory_visualizer-srv:message-val is deprecated.  Use trajectory_visualizer-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveTrajectory-response>) ostream)
  "Serializes a message object of type '<SaveTrajectory-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveTrajectory-response>) istream)
  "Deserializes a message object of type '<SaveTrajectory-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveTrajectory-response>)))
  "Returns string type for a service object of type '<SaveTrajectory-response>"
  "trajectory_visualizer/SaveTrajectoryResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveTrajectory-response)))
  "Returns string type for a service object of type 'SaveTrajectory-response"
  "trajectory_visualizer/SaveTrajectoryResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveTrajectory-response>)))
  "Returns md5sum for a message object of type '<SaveTrajectory-response>"
  "1627d748845e26865bbe2f4eb092df90")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveTrajectory-response)))
  "Returns md5sum for a message object of type 'SaveTrajectory-response"
  "1627d748845e26865bbe2f4eb092df90")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveTrajectory-response>)))
  "Returns full string definition for message of type '<SaveTrajectory-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveTrajectory-response)))
  "Returns full string definition for message of type 'SaveTrajectory-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveTrajectory-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveTrajectory-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveTrajectory-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SaveTrajectory)))
  'SaveTrajectory-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SaveTrajectory)))
  'SaveTrajectory-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveTrajectory)))
  "Returns string type for a service object of type '<SaveTrajectory>"
  "trajectory_visualizer/SaveTrajectory")