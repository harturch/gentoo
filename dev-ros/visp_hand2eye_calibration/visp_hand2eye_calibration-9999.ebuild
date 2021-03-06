# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
ROS_REPO_URI="https://github.com/lagadic/vision_visp"
KEYWORDS="~amd64 ~arm"
VER_PREFIX="jade-"
ROS_SUBDIR=${PN}
CATKIN_HAS_MESSAGES=yes
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
CATKIN_MESSAGES_TRANSITIVE_DEPS="dev-ros/std_msgs dev-ros/geometry_msgs"

inherit ros-catkin

DESCRIPTION="Estimates the camera position with respect to its effector using the ViSP library"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-ros/image_proc
	dev-ros/roscpp
	dev-ros/sensor_msgs
	dev-ros/visp_bridge
	dev-ros/visp_tracker
	sci-libs/ViSP:=
"
DEPEND="${RDEPEND}"
if [ "${PV#9999}" = "${PV}" ] ; then
	S="${WORKDIR}/vision_visp-jade-${PV}/${ROS_SUBDIR}"
fi
