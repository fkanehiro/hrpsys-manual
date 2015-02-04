===========
 Simulator
===========

hrpsys-base provides following system composer integrated with physics simulation.

hrpsys-simulator command
========================

The hrpsys-simulator command loads and runs a simulation. It is called like follows::
  
  $ hrpsys-simulator [project file] [options]

Where **project file** is the xml file which defines system composition and simulation world (explained later).

The hrpsys-simulator command has following options:

.. program:: hrpsys-simulator

.. option:: -nodisplay

   Headless mode.

.. option:: -realtime
   
   Synchronize to real world time.

.. option:: -usebbox
   
   Use bounding box for collision detection.

.. option:: -endless

   Endless mode.

.. option:: -showsensors

   Visualize sensors.

.. option:: -size [pixels]

   Specify window size in pixels.

.. option:: -no-default-lights

   Disable ambient light (simulation environment will be dark).

.. option:: -max-edge-length [value]

   Specify maximum length of polygon edge (if exceed, polygon will be divided to improve rendering quality).

.. option:: -max-log-length [value]

   Specify maximum size of the log.

.. option:: -exit-on-finish

   Exit the program when the simulation finish.

.. option:: -record

   Record the simulation as movie.

.. option:: -bg [r] [g] [b]

   Specify background color.

.. option:: -h --help

   Show help message.

hrpsys-simulator-python command
===============================

The hrpsys-simulator-python command loads and runs a simulation. It is called like follows::
  
  $ hrpsys-simulator-python [project file] [python script] [options]

Where **project file** is the xml file which defines system composition and simulation world (explained later) and **python script** is the python script executed when the simulation start.

hrpsys-simulator-python command can take same option as the hrpsys-simulator.

After the system and the simulation has initialized hrpsys-simulator-python will show interactive prompt where you can control the system and the simulation interactively using the python commands.

hrpsys-simulator-jython command
===============================

The hrpsys-simulator-jython command loads and runs a simulation. It is called like follows::
  
  $ hrpsys-simulator-jython [project file] [jython script] [options]

Where **project file** is the xml file which defines system composition and simulation world (explained later) and **python script** is the jython script executed when the simulation start.

hrpsys-simulator-jython command can take same option as the hrpsys-simulator.

After the system and the simulation has initialized hrpsys-simulator-jython will show interactive prompt where you can control the system and the simulation interactively using the jython commands.

XML project file format
=======================

Project file is in XML format consists of plural configuration items.
Each types of configuration items are distinguished with **class attributes**.
hrpsys-simulator currently has following configuration item types:

com.generalrobotix.ui.item.GrxRTSItem
    Defines initialization and connection of RT-components.

com.generalrobotix.ui.item.GrxModelItem
    Defines robot model and initial attitudes.

com.generalrobotix.ui.item.GrxCollisionPairItem
    Defines collision pair of two objects.

com.generalrobotix.ui.item.GrxWorldStateItem
    Defines physics simulation parameters.

com.generalrobotix.ui.item.GrxPythonScriptItem
    Defines python script to be run behind the simulation.

com.generalrobotix.ui.view.Grx3DView
    Defines initial view angle and visualization settings.

There are some other configuration item types such as com.generalrobotix.ui.grxui.GrxUIPerspectiveFactory. These are the legacy item types used in previous eclipse based OpenHRP simulator. These items are kept for compatibility reason and has no effect to hrpsys-simulator.

GrxRTSItem
----------

In **com.generalrobotix.ui.item.GrxRTSItem** configuration item type, the name "*.period" is used to specify execution cycle of each RT-components. The name "*.factory" is used to specify the name of shared library used to create the instance of the component. Properties with name "connection" specify the connection between the components.

Following is the example of the configuration:

.. code-block:: xml
   :linenos:

   <item class="com.generalrobotix.ui.item.GrxRTSItem" name="untitled" select="true">
	    <property name="PA10Controller0.period" value="0.005"/>  
	    <property name="HGcontroller0.period" value="0.005"/>  
	    <property name="HGcontroller0.factory" value="HGcontroller"/>  
	    <property name="connection" value="HGcontroller0.qOut:PA10Controller0.qRef"/>
	    <property name="connection" value="HGcontroller0.dqOut:PA10Controller0.dqRef"/>
	    <property name="connection" value="HGcontroller0.ddqOut:PA10Controller0.ddqRef"/>
   </item>

GrxModelItem
------------

In **com.generalrobotix.ui.item.ModelItem** configuration item type, following configuration can be used.

Model related configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Attribute "name" and "url" given to the configuration item itself specifies the name and location of the model file.

The name "isRobot" specifies if the model will be treated as a robot which has dynamic parameters.

Joint related configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~
The name "\*.mode" is used to specify the mode of the joint. If value "HighGain" is set, the joint can be controlled either by angle, velocity or acceleration of the joint. If not specified, the joint will be configured to use torque mode.

The name "\*.angle" is used to specify initial joint angle.

The name "\*.velocity" is used to specify initial joint velocity.

The name "\*.angularVelocity" is used to specify initial angular velocity.

Link related configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

The name "\*.translation" is used to specify initial translation of the link in [x, y, z] axis.

The name "\*.rotation" is used to specify initial rotation in VRML rotation format.

The name "\*.collisionShape" is used to specify collision detection method. If not specified, use default (slow but accurate) collision detection algorithm. If "convex hull" is specified, it convert the shape to convex hull (faster but less accurate). If "AABB" is specified, it will use bounding box for collision detection.

The name "\*.NumOfAABB" is used to specify number of AABB used for collision detection (smaller will be faster, but less accurate).

RT-Component related configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The name "rtcName" is used to specify the name used to expose the interface of the model as a RT-Component.

The name "inport" and "outport" is used to create inport and outport. Value is defined in "[port name]:[elements]:[data type]".

For input and output ports we can specify following data type:

JOINT_VALUE
  Value of joints specified in element part.

JOINT_VELOCITY
  Velocity of joints specified in element part.

JOINT_ACCELERATION
  Acceleration of joints specified in element part.

JOINT_TORQUE
  Torque of joints specified in element part.

ABS_TRANSFORM
  Absolute transform of joint specified in element part.

ABS_VELOCITY
  Absolute velocity of joint specified in element part.

ABS_ACCELERATION
  Absolute acceleration of joint specified in element part.

For inport we can specify following data type:

FRAME_RATE
  Frame rate of the vision sensor specified in element part.

LIGHT_SWITCH
  Switch of the light specified in element part.

For outport we can specify following data type:

FORCE_SENSOR
  Value of force sensor.

RATE_GYRO_SENSOR
  Value of rate gyro sensor.

ACCELERATION_SENSOR
  Value of acceleration sensor.

RANGE_SENSOR
  Value of range sensor.

VISION_SENSOR
  Value of vision sensor.

POINT_CLOUD
  Value of point cloud.


GrxCollisionPairItem
--------------------

GrxCollisionPairItem can specify following properties:

objectName1
  Specifies one object name to detect collision.

objectName2
  Specifies opponent object name to detect collision.

jointName1
  Specifies joint name on one object to detect collision. If not specified, whole the joints of the object body is detected.

jointName2
  Specifies joint name on opponent object to detect collision. If not specified, whole the joints of the object body is detected.

slidingFriction
  Specifies sliding friction between the objects.

staticFriction
  Specifies static friction between the objects.

cullingThresh
  Specifies culling threshold.

Restitution
  Specifies restitution coefficient.

GrxWorldStateItem
-----------------

GrxWorldStateItem can specify following properties:

totalTime
  Specify total time of simulation.

timeStep
  Specify simulation time step.

realTime
  If "true" synchronize to real world time.

gravity
  Specify gravity power.

method
  If "EULER" use euler method. Other, use runge-kutta.

integrate
  If "false" use kinematics only mode.

GrxPythonScriptItem
-------------------

GrxPythonScriptItem can specify following properties:

name
  Specify name of the script item.

url
  Specify url of the python script.


Grx3DView
---------

Grx3DViewItem can specify following properties:

showScale
  Show scale in simulation screen.

showCoM
  Show center of mass in simulation screen.

showCoMonFloor
  Show center of mass on the floor in simulation screen.

showCollision
  Visualize collision points in simulation screen.

eyeHomePosition
  Set view angle in simulation screen.
