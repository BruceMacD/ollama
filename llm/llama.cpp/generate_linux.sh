#!/bin/bash

# only do gpu builds if nvcc is installed
if which nvcc > /dev/null; then
  # get cuda version information
  CUDA_VERSION_STR=$(nvcc --version)

  # parse cuda major version
  CUDA_MAJOR_VERSION=$(echo "$CUDA_VERSION_STR" | grep -o -E 'release ([0-9]+)\.' | awk '{print $2}' | tr -d '.')
  
  cmake -S ggml -B ggml/build/cuda/$CUDA_MAJOR_VERSION -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build ggml/build/cuda/$CUDA_MAJOR__VERSION --target server --config Release

  cmake -S gguf -B gguf/build/cuda/$CUDA_MAJOR_VERSION -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build gguf/build/cuda/$CUDA_MAJOR_VERSION --target server --config Release
else
  echo "Warning: nvcc is not installed, skipping cuda builds."
fi