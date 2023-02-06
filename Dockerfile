FROM ros:noetic-ros-core

SHELL ["/bin/bash", "-c"]

WORKDIR /ros_ws

RUN apt-get update && \
    apt-get install -y \
        git \
        build-essential \
        python3-pip && \
    pip3 install \
        rosdep \
        vcstool && \
    git clone https://github.com/husarion/ur_onrobot_rg2_ros.git src && \
    vcs import src < src/onrobot_rg2/onrobot_rg2.repos && \
    rosdep init && \
    rosdep update --rosdistro=$ROS_DISTRO && \
    rosdep install --from-paths src --ignore-src -y && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
