# Get the base image
FROM vtk-wasm

# Create and set working directory
RUN mkdir -p /src/vtk-wasm-test
WORKDIR /src/vtk-wasm-test

# Copy source files
COPY ./src ./src

# Build source files
RUN mkdir build && \
  cd build && \
  cmake \
    -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
    -DVTK_DIR=/src/vtk-build \
    -DOPTIMIZE=BEST \
    ../src && \
  cmake --build .

# Expose port
EXPOSE ${PORT}

# Run
CMD cd build && python3 -m http.server ${PORT}
