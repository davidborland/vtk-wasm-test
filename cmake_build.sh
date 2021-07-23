#docker exec -w /src/vtk-wasm-test/build vtk-wasm-test_client ninja -t clean Cone
#docker exec -w /src/vtk-wasm-test/build vtk-wasm-test_client ninja
#docker exec -w /src/vtk-wasm-test/build vtk-wasm-test_client cmake . --target clean
#docker exec -w /src/vtk-wasm-test/build vtk-wasm-test_client cmake --clean-first .

#docker exec -w /src/vtk-wasm-test/build vtk-wasm-test_client cmake \
#  -G Ninja \
#  -DCMAKE_TOOLCHAIN_FILE=/emsdk_portable/emscripten/sdk/cmake/Modules/Platform/Emscripten.cmake \
#  -DVTK_DIR=/src/vtk-build \
#  -DOPTIMIZE=BEST \
#  ../src \
docker exec -w /src/vtk-wasm-test/build vtk-wasm-test_client cmake --build . --target clean
docker exec -w /src/vtk-wasm-test/build vtk-wasm-test_client cmake --build .