#!/bin/sh

current_folder=`pwd`
echo "Current Folder : $current_folder"

############################
# Installation of libraries
############################
sudo apt-get install  freeglut3-dev g++


libusb(){
cd $current_folder
git clone https://github.com/libusb/libusb.git
cd libusb
git checkout tags/v1.0.9
git checkout -b v1.0.9	
./autogen.sh
./configure --prefix=/usr --disable-static
make
sudo make install
}


############################
# Installing Openni
############################
OpenNI() {
cd $current_folder
git clone https://github.com/OpenNI/OpenNI.git
cd  OpenNI
git checkout tags/Unstable-1.5.8.5
git checkout -b Unstable-1.5.8.5

cd ./Platform/Linux/CreateRedist/
./RedistMaker

cd   $current_folder/OpenNI/Platform/Linux/Redist/OpenNI-Bin-Dev-Linux-x64-v1.5.4.0/
sudo ./install.sh -i
}


######################################
#  Installing Avin2 SensorSkin
######################################
SensorSkin() {
cd $current_folder
git clone https://github.com/avin2/SensorKinect.git
cd  SensorKinect

git checkout -b  unstable origin/unstable 
cd  ./Platform/Linux/CreateRedist
./RedistMaker
cd $current_folder/SensorKinect/Platform/Linux/Redist/Sensor-Bin-Linux-x64-v5.1.2.1/
sudo ./install.sh -i
#./install.sh -u  # To uninstall
}

NITE() {
cd $current_folder
wget http://dahoo.fr/dahoo_rsc/Ressources/openNi/NiTE%20v1.5.2.23/NITE-Bin-Linux-x64-v1.5.2.23.tar.zip
unzip NITE-Bin-Linux-x64-v1.5.2.23.tar.zip
tar xjvf NITE-Bin-Linux-x64-v1.5.2.23.tar.bz2
mv NITE-Bin-Dev-Linux-x64-v1.5.2.23/ nite/
rm NITE-Bin-Linux-x64-v1.5.2.23.tar.bz2

cd nite/
chmod u+x install.sh
sudo ./install.sh

}


libusb
OpenNI
SensorSkin
NITE


sudo modprobe -r gspca_kinect
sudo modprobe -r gspca_main