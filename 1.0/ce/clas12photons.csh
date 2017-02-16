#!/bin/csh -f

#Source this script to use clas12photons software
#Requires full installation of jlab12 software from CE package

#print only if there is a prompt
alias echo 'if($?prompt) echo \!*  '


# Looking for user defined JLAB_VERSION
if( ! $?CLAS12PHOTONS_VERSION || $overwrite == "yes") then
	setenv CLAS12PHOTONS_VERSION 1.0
endif





# Software packages
set packages = (OpenMPI AmpTools Clas12PhotonsAmpTools)



# Do not edit below this line
##################################################################################################
echo

if (! $?JLAB_SOFTWARE) then
    echo "####################################################################################"
    echo "####################################################################################"
    echo "       This script requires that the user already sourced JLAB CE software          "
    echo "Look at https://www.jlab.org/12gev_phys/packages/sources/ceInstall/2.0_install.html "
    echo "                             Ending now                                             "
    echo "####################################################################################"
    echo "####################################################################################"
    exit 1
endif

if (! $?CLAS12PHOTONS_ROOT) then
    echo "#######################################################################################"
    echo "#######################################################################################"
    echo "This script requires that the user already set CLAS12PHOTONS_ROOT environmental var    "
    echo " In your .cshrc, do setenv CLAS12PHOTONS_ROOT  folder_where_clas12photons_is_installed "
    echo "#######################################################################################"
    echo "#######################################################################################"
    exit 1
endif


# Sourcing packages. This will set the LD_LIBRARY_PATH. 
# Powerpcs and Darwins will be set right below
if( ! $?LD_LIBRARY_PATH) then
	setenv LD_LIBRARY_PATH ""
endif
if( ! $?PYTHONPATH) then
	setenv PYTHONPATH "."
endif



setenv CLAS12PHOTONS_SOFTWARE $CLAS12PHOTONS_ROOT/$CLAS12PHOTONS_VERSION/$OSRELEASE

echo
echo " > CLAS12Photons software Version: <"$CLAS12PHOTONS_VERSION"> "
echo " > Running as "`whoami` on `hostname`
echo " > OS Release:    "$OSRELEASE
echo " > CLAS12PHOTONS_ROOT set to:     "$CLAS12PHOTONS_ROOT

source $CLAS12PHOTONS_ROOT/$CLAS12PHOTONS_VERSION/ce/versions.env


if( -d $CLAS12PHOTONS_SOFTWARE) then
	echo " > CLAS12PHOTONS_SOFTWARE set to: "$CLAS12PHOTONS_SOFTWARE
else
	mkdir -p $CLAS12PHOTONS_SOFTWARE
	echo " > '$CLAS12PHOTONS_SOFTWARE' is not a directory. Creating it."
endif
echo


foreach p ($packages)
	source $CLAS12PHOTONS_ROOT/$CLAS12PHOTONS_VERSION/ce/$p".env"
end


#4: Derek Event Generator
setenv EDGEN $CLAS12PHOTONS_ROOT/$OSRELEASE/EdGen
if( ! -d $EDGEN/lib ) then
	echo " ? Attention: No EdGen installation found."
else
	echo " > EdGEN is installed in:  " $EDGEN
	setenv LD_LIBRARY_PATH ${EDGEN}/lib:${LD_LIBRARY_PATH}
endif


#5: FASTMC (fortran)
setenv FASTMC $CLAS12PHOTONS_ROOT/$OSRELEASE/fastmc
if( ! -d $EDGEN ) then
	echo " ? Attention: No FASTMC installation found."
else
	echo " > FASTMC is installed in:  " $FASTMC
	setenv LD_LIBRARY_PATH ${FASTMC}:${LD_LIBRARY_PATH}
endif

#6: FASTMC c++ wrapper
setenv ROOT_FASTMC $CLAS12PHOTONS_ROOT/$OSRELEASE/root_fastmc
if( ! -d $ROOT_FASTMC ) then
	echo " ? Attention: No FASTMC C++ Wrapper installation found."
else
	echo " > FASTMC C++ Wrapper is installed in:  " $ROOT_FASTMC
	setenv LD_LIBRARY_PATH ${ROOT_FASTMC}:${LD_LIBRARY_PATH}
endif


unalias echo
