# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

SCM=""
if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/PointCloudLibrary/pcl"
fi

inherit ${SCM} cmake-utils multilib

if [ "${PV#9999}" != "${PV}" ] ; then
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~amd64 ~arm"
	SRC_URI="https://github.com/PointCloudLibrary/pcl/archive/${P}.tar.gz"
	S="${WORKDIR}/${PN}-${P}"
fi

HOMEPAGE="http://pointclouds.org/"
DESCRIPTION="2D/3D image and point cloud processing"
LICENSE="BSD"
SLOT="0"
IUSE="cuda doc opengl openni openni2 pcap png +qhull qt4 usb vtk cpu_flags_x86_sse test tutorials"

RDEPEND="
	>=sci-libs/flann-1.7.1
	dev-libs/boost:=[threads]
	dev-cpp/eigen:3
	opengl? ( virtual/opengl media-libs/freeglut )
	openni? ( dev-libs/OpenNI )
	openni2? ( dev-libs/OpenNI2 )
	pcap? ( net-libs/libpcap )
	png? ( media-libs/libpng:0= )
	qhull? ( media-libs/qhull )
	qt4? ( dev-qt/qtgui:4 )
	usb? ( virtual/libusb:1 )
	vtk? ( >=sci-libs/vtk-5.6[imaging,rendering,qt4?] )
	cuda? ( >=dev-util/nvidia-cuda-toolkit-4 )
"
DEPEND="${RDEPEND}
	!!dev-cpp/metslib
	doc? ( app-doc/doxygen )
	tutorials? ( dev-python/sphinx dev-python/sphinxcontrib-doxylink )
	test? ( >=dev-cpp/gtest-1.6.0 )
	virtual/pkgconfig"

REQUIRED_USE="
	openni? ( usb )
	openni2? ( usb )
	tutorials? ( doc )
"

src_configure() {
	local mycmakeargs=(
		"-DLIB_INSTALL_DIR=$(get_libdir)"
		"-DWITH_CUDA=$(usex cuda TRUE FALSE)"
		"-DWITH_LIBUSB=$(usex usb TRUE FALSE)"
		"-DWITH_OPENGL=$(usex opengl TRUE FALSE)"
		"-DWITH_PNG=$(usex png TRUE FALSE)"
		"-DWITH_QHULL=$(usex qhull TRUE FALSE)"
		"-DWITH_QT=$(usex qt4 TRUE FALSE)"
		"-DWITH_VTK=$(usex vtk TRUE FALSE)"
		"-DWITH_PCAP=$(usex pcap TRUE FALSE)"
		"-DWITH_OPENNI=$(usex openni TRUE FALSE)"
		"-DBUILD_OPENNI=$(usex openni TRUE FALSE)"
		"-DWITH_OPENNI2=$(usex openni2 TRUE FALSE)"
		"-DBUILD_OPENNI2=$(usex openni2 TRUE FALSE)"
		"-DPCL_ENABLE_SSE=$(usex cpu_flags_x86_sse TRUE FALSE)"
		"-DWITH_DOCS=$(usex doc TRUE FALSE)"
		"-DWITH_TUTORIALS=$(usex tutorials TRUE FALSE)"
		"-DBUILD_TESTS=$(usex test TRUE FALSE)"
	)
	cmake-utils_src_configure
}
