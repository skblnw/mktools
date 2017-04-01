#!/bin/bash

# Prerequisites 
# Intel compiler (2013)
source /opt/intel/composer_xe_2013.0.079/bin/iccvars.sh intel64
source /opt/intel/composer_xe_2013.0.079/bin/ifortvars.sh intel64
# MKL library
source /opt/intel/composer_xe_2013.0.079/mkl/bin/mklvars.sh intel64
export LD_LIBRARY_PATH=/vol6/intel_composer_xe_2013.0.079_lib:$LD_LIBRARY_PATH
# MPI (Intel 2013)
source /opt/intel/composer_xe_2013.0.079/bin/iccvars.sh intel64
source /opt/intel/composer_xe_2013.0.079/bin/ifortvars.sh intel64
export PATH=/vol6/software/mpi/mpi-inel2013/bin:$PATH
export LD_LIBRARY_PATH=/vol6/software/mpi/mpi-intel2013/lib:$LD_LIBRARY_PATH
