#!/bin/bash

# Find the latest CUDA 11 nvcc
latest_cuda_11=$(ls /usr/local | grep -E 'cuda-11\.[0-9]+$' | sort -V | tail -n 1)

# Find the latest CUDA 12 nvcc
latest_cuda_12=$(ls /usr/local | grep -E 'cuda-12\.[0-9]+$' | sort -V | tail -n 1)

if [ ! -z "$latest_cuda_11" ]; then
  cuda_11_nvcc_path="/usr/local/$latest_cuda_11/bin/nvcc"
  echo "Found CUDA 11 nvcc at $cuda_11_nvcc_path"

  cmake -S ggml -B ggml/build/cuda-11 -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build ggml/build/cuda-11 --target server --config Release

  cmake -S gguf -B gguf/build/cuda-11 -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build gguf/build/cuda-11 --target server --config Release
fi

if [ ! -z "$latest_cuda_12" ]; then
  cuda_12_nvcc_path="/usr/local/$latest_cuda_12/bin/nvcc"
  echo "Found CUDA 12 nvcc at $cuda_12_nvcc_path"

  cmake -S ggml -B ggml/build/cuda-12 -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build ggml/build/cuda-12 --target server --config Release

  cmake -S gguf -B gguf/build/cuda-12 -DLLAMA_CUBLAS=on -DLLAMA_ACCELERATE=on -DLLAMA_K_QUANTS=on
  cmake --build gguf/build/cuda-12 --target server --config Release
fi