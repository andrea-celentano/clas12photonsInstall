# clas12photonsInstall - requires csh shell

## Download the software (eventually, change 1.2.2 with the latest release)
wget https://github.com/andrea-celentano/clas12photonsInstall/archive/1.2.2.tar.gz --no-check-certificate

## Install it in a folder on your machine (again, eventually change 1.2.2 with the latest release)

cd /path/to/your/installation/folder
tar -zxvf 1.2.2.tar.gz
mv clas12photonsInstall-1.2.2 1.2.2

## Modify your .cshrc login script

Add the following lines

setenv CLAS12PHOTONS_ROOT /path/to/your/installation/folder
setenv CLAS12PHOTONS_VERSION 1.2.2
source $CLAS12PHOTONS_ROOT/$CLAS12PHOTONS_VERSION/ce/clas12photons.csh keepmine

## Compile

cd $CLAS12PHOTONS_ROOT/$CLAS12PHOTONS_VERSION/install 
./go_AmpTools
./go_Clas12PhotonsAmpTools
