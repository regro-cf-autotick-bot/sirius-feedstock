set -ex
mkdir -p build
cd build

if [[ ${mpi} == "mpich" ]]; then
   # Allow argument mismatch in Fortran
   # https://github.com/pmodels/mpich/issues/4300
   export FFLAGS="$FFLAGS -fallow-argument-mismatch"
   export FCFLAGS="$FCFLAGS -fallow-argument-mismatch"
fi
cmake .. \
  ${CMAKE_ARGS} \
  -DUSE_MKL=OFF \
  -DUSE_SCALAPACK=ON \
  -DUSE_OPENMP=ON \
  -DCREATE_PYTHON_MODULE=OFF \
  -DCREATE_FORTRAN_BINDINGS=ON

make -j${CPU_COUNT} install
