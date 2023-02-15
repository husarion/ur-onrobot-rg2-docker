# ur-onrobot-rg2-docker
Docker image with ROS packages from [ur_onrobot_rg2_ros](https://github.com/husarion/ur_onrobot_rg2_ros) repo.

> **Warning**
>
> Please note that this is only temporary solution. Driver node uses UR robot analog and digital IO for communication (`analog_out_0`, `analog_out_1`, and `digital_out_0`).
>
> You can find more information in this [issue](https://github.com/UniversalRobots/Universal_Robots_ROS_Driver/issues/611).

# Quick Start

To run the ROS packages provided in this repository with real or simulated Onrobot RG2 gripper and UR5e manipulator (using a Docker configuration), please refer to the examples available in [ur-docker](https://github.com/husarion/ur-docker#ur5e-onrobot-rg2) repo.


# Prerequisites

Connect to the Panther WiFi network and open UR robot computer GUI:
```bash
xtightserver 10.15.20.4
```
Before proceeding, make sure that the `husarion_ext_control.urp` program exists and can be loaded (`program` -> `load`). If the program is missing, copy the files provided in the `ur-programs` folder to the `/programs` directory on the UR computer, i.e via `sftp`:
```bash
sftp root@10.15.20.4
# default password: husarion
```
Continue by following the instructions in [ur-docker](https://github.com/husarion/ur-docker) README.md

# Control Your Gripper

## Real Case

> **Warning**
>
> Please note that this is only temporary solution ([issue](https://github.com/UniversalRobots/Universal_Robots_ROS_Driver/issues/611)).

To control the RG2 gripper, you need to call `rg2/set_gripper_width` service (`GripperState` custom type) with a float range from 0.0 to 1.0. The value of 0.0 corresponds to a closed gripper, while the value of 1.0 corresponds to a fully open gripper with a range of 100mm. In order to control the position of the gripper, you can adjust the value within this range.

## Simulation

To control the RG2 gripper in the Gazebo simulator using the ros_control package, you need to publish a message to the `/gripper_joint_position/command` topic with a float range from -0.44 to 1.0. This range corresponds to the state of the joint controlling the gripper. A value of 1.0 corresponds to a fully open gripper with a range of 100mm, while a value of 0 corresponds to a closed gripper. Adjust the value within this range to control the position of the gripper in the simulation. Please note that this range is different from the real-life usage of the RG2 gripper due to the use of the ros_control package in the Gazebo simulator.