
(cl:in-package :asdf)

(defsystem "trajectory_visualizer-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "SaveTrajectory" :depends-on ("_package_SaveTrajectory"))
    (:file "_package_SaveTrajectory" :depends-on ("_package"))
  ))