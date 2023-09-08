#!/bin/bash

# only do gpu builds if nvcc is installed
if which nvcc > /dev/null; then
  # get cuda version information
  CUDA_MAJOR_VERSION=$(nvidia-smi | awk -F': ' '/CUDA Version/ {print $3}' | awk -F' ' '{print $1}' | awk -F'.' '{print $1}')
  
  cmake -S ggml -B ggml/build/cuda-$CUDA_MAJOR_VERSION -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build ggml/build/cuda-$CUDA_MAJOR_VERSION --target server --config Release

  cmake -S gguf -B gguf/build/cuda-$CUDA_MAJOR_VERSION -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build gguf/build/cuda-$CUDA_MAJOR_VERSION --target server --config Release
else
  echo "Warning: nvcc is not installed, skipping cuda builds."
fi