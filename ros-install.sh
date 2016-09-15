#Author = Harsh
#Date	= 15 Aug 2016
#Time	= 5:14:49 AM
#!/bin/bash

clear
timeout 60 echo -n "Running This Script will install ROS Kinetic Kame, Continue ? (Y/n)..."
read cond
if [[ ( $cond == y ) || ( $cond == Y ) ]]
then
{
	. /etc/lsb-release
	OS=$DISTRIB_ID
	VER=$DISTRIB_RELEASE
	
	if [[ ( $OS == Ubuntu ) && ( ( $VER == 16.04 ) || ( $VER == 15.10 ) ) ]]
	then
	{
		echo "Installing ...";
		sleep 1;
		echo "Setting Up Sources.list ..."
		sleep 1;
		sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
		sleep 1;
		if grep -Fxq "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" /etc/apt/sources.list.d/ros-latest.list
		then
		echo "Checking /etc/apt/sources.list.d/ros-latest.list ..."
		sleep 1;
		echo "Required repository found!";
		sleep 1;
		else
		echo "Can't add the required Repository ...";
		sleep 1;
		echo "Exiting ..."
		sleep 1;
		exit;
		fi
		echo "Done!"
		sleep 1;
		echo "Checking for keys ..."
		if sudo apt-key list | grep -q  "ROS Builder <rosbuild@ros.org>"
		then
		echo "Key already Exists, Skipping ..."
		sleep 1;
		else
		echo "Setting Up Keys ..."
		sleep 1;
		wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
		sleep 1;
		echo "Done!"
		sleep 1;
		fi
		echo "Updating Package Index ..."
		sleep 1;
		sudo apt-get update;
		sleep 1;
		echo "Done!"
		sleep 1;
		clear
		echo "---Available ROS Installations---"
		echo "1. Desktop-Full Install: (Recommended) : ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators, navigation and 2D/3D perception"
		echo "2. Desktop Install: ROS, rqt, rviz, and robot-generic libraries"
		echo "3. ROS-Base: (Bare Bones) ROS package, build, and communication libraries. No GUI tools."
		timeout 60 echo -n "Enter Choice (1-3) ..."
		while read version; do
			if [[ ( $version > 0 ) && ( $version < 4 ) ]]
			then
			{
				case $version in
				1)
					echo "Installing ros-kinetic-desktop-full ...";
					sleep 1;
					sudo apt-get install ros-kinetic-desktop-full;
					sleep 1;
					echo "Done!"
					sleep 1;
					clear
				;;
				2)
					echo "Installing ros-kinetic-desktop ...";
					sleep 1;
					sudo apt-get install ros-kinetic-desktop;
					sleep 1;
					echo "Done!"
					sleep 1;
					clear
				;;
				3)
					echo "Installing ros-kinetic-ros-base ...";
					sleep 1;
					sudo apt-get install ros-kinetic-ros-base;
					sleep 1;
					echo "Done!"
					sleep 1;
					clear
				;;
				esac
				break;
			}
			else
			{
				echo "Incorrect Choice!"
				sleep 1;
				timeout 60 echo -n "Enter Choice (1-3) ..."
			} fi
		
		done
		echo "Initializing rosdep ..."
		sleep 1;
		sudo rosdep init
		rosdep update
		sleep 1;
		echo "Done!"
		sleep 1;
		echo "Setting Up Environment ..."
		sleep 1;
		echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
		source ~/.bashrc
		sleep 1;
		echo "Done!"
		sleep 1;
		echo "Getting rosinstall ..."
		sleep 1;
		sudo apt-get install python-rosinstall
		sleep 1;
		echo "Done!"
		sleep 1;
		echo "ROS - Kinetic Kame is successfully installed !";
		sleep 1;
		echo "Rebooting in 10 sec (Press Ctrl+C for interrupt) ..."
		sleep 10
		reboot;
	exit;
	}
	
	else
	{
		echo -n $OS " "$VER " ";echo -n "is not a supported OS for Kinetic Kame.";echo "";
		exit;
	} fi
}
else
{
	echo "Exiting...";
	sleep 1;
	clear
	exit;
} fi
