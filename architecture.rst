==============
 Architecture
==============

hrpsys-base is a set of reusable components but also an environment to compose robotic applications integrated with physics simulator to test the applications.

Overall architecture of hrpsys-base is as follows:

.. graphviz::

   digraph foo {
      components [label="Collection of components"]
      xml [label="XML based\nsystem composer"]
      python [label="Python based\nsystem composer"]
      simulator [label="Physics simulator"]
      application [label="Actual robot"]
      components -> xml
      components -> python
      xml -> simulator
      python -> simulator
      xml -> application
      python -> application
   }

Collection of components is implemented using OpenRTM-aist (http://openrtm.org/) described in :doc:`components`.

XML based system composer use XML based configuration file to compose the system and run the physics simulation (described in :doc:`simulator`).

Python script can also be used to compose the system and configure the physics simulation (described in :doc:`python`).

Physics simulator is integrated with XML based system composer and also can be used as a Python library.

In section :doc:`hardware`, method to apply to your own hardware is explained.

