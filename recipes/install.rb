#
# Cookbook Name:: thumbor_ng
# Recipe:: install
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'

  # apt repository configuration
  apt_repository 'thumbor' do
    uri node['thumbor_ng']['apt']['thumbor']['uri']
    distribution node['thumbor_ng']['apt']['thumbor']['distribution']
    components node['thumbor_ng']['apt']['thumbor']['components']
    keyserver node['thumbor_ng']['apt']['thumbor']['keyserver']
    key node['thumbor_ng']['apt']['thumbor']['key']
    deb_src node['thumbor_ng']['apt']['thumbor']['deb_src']
    action node['thumbor_ng']['apt']['thumbor']['action']
  end

  apt_repository 'multiverse' do
    uri node['thumbor_ng']['apt']['multiverse']['uri']
    distribution node['thumbor_ng']['apt']['multiverse']['distribution']
    components node['thumbor_ng']['apt']['multiverse']['components']
    deb_src node['thumbor_ng']['apt']['multiverse']['deb_src']
    action node['thumbor_ng']['apt']['multiverse']['action']
  end

  required_packages = %w(libopencv-dev libevent-dev libxml2-dev libcurl4-gnutls-dev python-pycurl-dbg
                         librtmp-dev libatlas-base-dev gfortran liblapack-dev libblas-dev build-essential
                         checkinstall git pkg-config cmake libpng12-0 libpng12-dev libpng++-dev libpng3
                         libpnglite-dev libfaac-dev libjack-jackd2-dev libjasper-dev libjasper-runtime
                         libjasper1 libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev
                         libtheora-dev libva-dev libvdpau-dev libvorbis-dev libx11-dev libxfixes-dev libxvidcore-dev
                         texi2html yasm zlib1g-dev zlib1g-dbg zlib1g libgstreamer0.10-0 libgstreamer0.10-dev libgstreamer0.10-0-dbg
                         gstreamer0.10-tools gstreamer0.10-plugins-base libgstreamer-plugins-base0.10-dev gstreamer0.10-plugins-good
                         gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad gstreamer0.10-ffmpeg pngtools libtiff4-dev libtiff4
                         libtiffxx0c2 libtiff-tools libjpeg8 libjpeg8-dev libjpeg8-dbg libjpeg-progs libavcodec-dev libavcodec53
                         libavformat53 libavformat-dev libxine1-ffmpeg libxine-dev libxine1-bin libunicap2 libunicap2-dev
                         libdc1394-22-dev libdc1394-22 libdc1394-utils swig libjpeg-progs libjpeg-dev libgtk2.0-0 libgtk2.0-dev
                         gtk2-engines-pixbuf python-numpy python-opencv libgraphicsmagick++1-dev libgraphicsmagick++3
                         libboost-python-dev tree webp libwebp-dev python-dateutil libqt4-dev libswscale-dev libtbb-dev
                         libv4l-dev v4l-utils x264 jpeginfo)

when 'rhel'
  required_packages = []
end

# install dependency packages
required_packages.each do |pkg|
  package pkg
end

# install dependency pip packages
python_pip 'remotecv'

python_pip 'graphicsmagick-engine'

# install thumbor
python_pip 'thumbor' do
  version node['thumbor_ng']['version']
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
end
