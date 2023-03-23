# ur-onrobot-rg2-docker
Docker image containing ROS packages from the [ur_onrobot_rg2_ros](https://github.com/husarion/ur_onrobot_rg2_ros) repo.

For more information, refer to [this issue](https://github.com/UniversalRobots/Universal_Robots_ROS_Driver/issues/611).

# Quick Start

To run the ROS packages provided in this repository with either a real or simulated OnRobot RG2 gripper and UR5e manipulator using a Docker configuration, refer to the examples available in the [ur-docker](https://github.com/husarion/ur-docker#ur5e-onrobot-rg2) repo.

You can also use the Docker configuration to view the Onrobot RG2 model in Rviz:

```bash
cd demo/
docker compose -f compose.wiev-rg2.yaml up
```

Alternatively, you can simulate the RG2 gripper in Gazebo-classic:

```bash
cd demo/
docker compose -f compose.gazebo.yaml up
```

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

Proceed by following the instructions in the [ur-docker](https://github.com/husarion/ur-docker) README.md

# Control Your Gripper

## Real Case

To control the RG2 gripper, call the `rg2/set_gripper_width` service with a float width range from 0.0 to 100.0 [mm] and force float range from 3.0 to 40.0 [N]. This custom service uses the `onrobot_rg2_driver/GripperState` type.

## Simulation

To control the RG2 gripper in the Gazebo simulator using the `ros_control` package, publish a message to the `/gripper_joint_position/command` topic with a float range from -0.44 to 1.0 [rad]. This range corresponds to the state of the joint controlling the gripper, where 1.0 represents a fully open gripper with a range of 100mm, and 0 represents a closed gripper. Adjust the value within this range to control the position of the gripper in the simulation. Note that this range is different from the real-life usage of the RG2 gripper due to the use of the `ros_control` package in the Gazebo simulator.