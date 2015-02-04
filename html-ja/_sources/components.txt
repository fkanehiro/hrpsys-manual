============
 Components
============

hrpsys-base comes with various components. In this section, we will explain part of it.

For full list of components, please see following url:

http://fkanehiro.github.io/hrpsys-base/

In this document, we use following convention to describe the component structure:

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="Component name\n[configuration parameter]"];
      p1 [shape=plaintext, label="Data type"];
      p2 [shape=plaintext, label="Service"];
      p3 [shape=plaintext, label="Data type"];
      p1 -> comp [label="Port name"];
      p2 -> comp [label="Service name", style=dashed];
      comp -> p3 [label="Outport name"];
   }

Image processing components
---------------------------

CameraImageViewer
=================

Open OpenCV highgui window to visualize the image captured by virtual of real camera.

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="CameraImageViewer"];
      p1 [shape=plaintext, label="Img::TimedCameraImage"];
      p1 -> comp [label="imageIn"];
   }

CameraCaptureService
====================

Filter to switch ON/OFF the image stream.

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="CameraCaptureService"];
      p1 [shape=plaintext, label="Img::TimedCameraImage"];
      p2 [shape=plaintext, label="Img::TimedCameraImage"];
      s [shape=plaintext, label="Img::CameraCaptureService"];
      p1 -> comp [label="imageIn"];
      comp -> p2 [label="imageOut"];
      s -> comp [label="service0", style=dashed];
   }

See `this page <http://fkanehiro.github.io/hrpsys-base/da/dad/interfaceImg_1_1CameraCaptureService.html>`_ for detail of the service.

RGB2Gray
========

Convert RGB image to grayscale.

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="RGB2Gray"];
      p1 [shape=plaintext, label="Img::TimedCameraImage"];
      p2 [shape=plaintext, label="Img::TimedCameraImage"];
      p1 -> comp [label="rgb"];
      comp -> p2 [label="gray"];
   }

ResizeImage
===========

Resize the input image with the given scale parameter.

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="ResizeImage\n[scale]"];
      p1 [shape=plaintext, label="Img::TimedCameraImage"];
      p2 [shape=plaintext, label="Img::TimedCameraImage"];
      p1 -> comp [label="original"];
      comp -> p2 [label="resized"];
   }

VideoCapture
============

Capture the image from hardware device using v4l API.

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="VideoCapture\n[initialMode, devIds,\nwidth, height\nframeRate]"];
      p1 [shape=plaintext, label="Img::TimedCameraImage"];
      p2 [shape=plaintext, label="Img::TimedMultiCameraImage"];
      s [shape=plaintext, label="Img::CameraCaptureService"];
      comp -> p1 [label="CameraImage"];
      comp -> p2 [label="MultiCameraImages"];
      s -> comp [label="CameraCaptureService", style=dashed];
   }

This component has following configuration parameters:

initialMode
  If set as "continuous" start capture on activation. Not start if not set (default: "continuous").

devIds
  Specify v4l device ID. If multiple IDs are set, synchronous capture will be applied (default "0").

width
  Capturing width (default: "640").

height
  Capturing height (default: "480").

frameRate
  Frame rate (default: "1").

Captured image will be output from CameraImage port, but if devIds are set for multiple devices MultiCameraImages port will be used for output.

Capturing can be also controlled as service, see `this page <http://fkanehiro.github.io/hrpsys-base/da/dad/interfaceImg_1_1CameraCaptureService.html>`_ for detail of the service.

Robot control components
------------------------

SequencePlayer
==============

Play motion patterns. Motion patterns can be list of each joint angles, list of keyframes or it also has inverse kinematics function to automatically estimate each joint angles given the list of target positions.

See `this page <http://fkanehiro.github.io/hrpsys-base/dd/d91/SequencePlayer.html>`_ for details.

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="SequencePlayer\n[debugLevel]"];
      qInit [shape=plaintext, label="RTC::TimedDoubleSeq"];
      basePosInit [shape=plaintext, label="RTC::TimedPoint3D"];
      baseRpyInit [shape=plaintext, label="RTC::TimedOrientation3D"];
      zmpRefInit [shape=plaintext, label="RTC::TimedPoint3D"];
      qRef [shape=plaintext, label="RTC::TimedDoubleSeq"];
      tqRef [shape=plaintext, label="RTC::TimedDoubleSeq"];
      zmpRef [shape=plaintext, label="RTC::TimedPoint3D"];
      accRef [shape=plaintext, label="RTC::TimedAcceleration3D"];
      basePos [shape=plaintext, label="RTC::TimedPoint3D"];
      baseRpy [shape=plaintext, label="RTC::TimedOrientation3D"];
      s [shape=plaintext, label="OpenHRP::SequencePlayerService"];
      qInit -> comp [label="qInit"];
      basePosInit -> comp [label="basePosInit"];
      baseRpyInit -> comp [label="baseRpyInit"];
      zmpRefInit -> comp [label="zmpInit"];
      comp -> qRef [label="qRef"];
      comp -> tqRef [label="tqRef"];
      comp -> zmpRef [label="zmpRef"];
      comp -> accRef [label="accRef"];
      comp -> basePos [label="basePos"];
      comp -> baseRpy [label="baseRpy"];
      s -> comp [label="service0", style=dashed];
   }


ServoController
===============

Control Futaba serial servo hardware.

.. graphviz::

   digraph comp {
      rankdir=LR;
      comp [shape=Mrecord, label="ServoController\n[servo.devname, servo.id,\nservo.offset, servo.dir]"];
      s [shape=plaintext, label="OpenHRP::ServoControllerService"];
      s -> comp [label="service0", style=dashed];
   }

This component has following configuration parameters:

servo.devname
  Device same of serial interface. Should be set to actual configuration such as "/dev/serusb1" (default: none).

servo.id
  IDs of servo devices. Set as comma separated values (default: none).

servo.offset
  Offset given to each servo devices (default: none).

servo.dir
  Set direction (1 or -1) of each servo devices (default: none).

Servos are controlled as service, see `this page <http://fkanehiro.github.io/hrpsys-base/d1/d5c/ServoController.html>`_ for detail of the service.
