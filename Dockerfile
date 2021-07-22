# Get the base image
FROM dockcross/web-wasm:20200416-a6b6635

# Get and build vtk
RUN git clone https://gitlab.kitware.com/vtk/vtk.git && \
  cd vtk && \
  git checkout 11fbec70^ && \
  git submodule update --init --recursive && \
  cd .. && \
  mkdir vtk-build && \
  cd vtk-build && \
  cmake \
    -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
    -DBUILD_SHARED_LIBS:BOOL=OFF \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DVTK_ENABLE_LOGGING:BOOL=OFF \
    -DVTK_ENABLE_WRAPPING:BOOL=OFF \
    -DVTK_LEGACY_REMOVE:BOOL=ON \
    -DVTK_OPENGL_USE_GLES:BOOL=ON \
    -DVTK_USE_SDL2:BOOL=ON \
    -DVTK_NO_PLATFORM_SOCKETS:BOOL=ON \
    -DVTK_MODULE_ENABLE_VTK_hdf5:STRING=NO \
    ../vtk && \
  cmake --build .

# Copy source files
COPY ./src ./src

# Build source files
RUN mkdir build && \
  cd build && \
  cmake \
    -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
    -DVTK_DIR=../vtk-build \
    -DOPTIMIZE=BEST \
    ../src && \
  cmake --build .

WORKDIR /build

# Run
CMD python3 -m http.server 8000
