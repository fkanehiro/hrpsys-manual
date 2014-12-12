==========================
 Apply to actual hardware
==========================

To apply the developed application to actual robotic hardware, there are two methods.

Replace the virtual device component to real device component
=============================================================

There are some real device components which has same port type exists already.
If your application only use these devices apply to real hardware is easy.

For v4l camera
  https://github.com/fkanehiro/hrpsys-base/tree/master/rtc/VideoCapture

For Hokuyo laser scanner
  http://gbiggs.github.io/rtchokuyoaist/

For Futaba serial servo
  https://github.com/fkanehiro/hrpsys-base/tree/master/rtc/ServoController

Create interface for your own robot
===================================

If your robot does not use any of the above devices, you have to write a glue code to interface your hardware to hrpsys.

IOB interface
-------------

IOB is a hardware abstraction interface defined `here <http://fkanehiro.github.io/hrpsys-base/de/ddc/iob_8h.html>`_.

To use this interface, include following header file and implement each functions based on the interface specification.
https://github.com/fkanehiro/hrpsys-base/blob/master/lib/io/iob.h

After the implementation of IOB is finished, compile your IOB to shared library named "libhrpIO.so".

In hrpsys, there is a dummy hrpIO library linked to and used by core hrpsys processes. If you want to use your real robot, replace the hrpIO library with the one compiled above.
