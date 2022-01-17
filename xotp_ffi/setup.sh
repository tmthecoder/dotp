#!/bin/bash

# Initializes Cargo to build all targets of xotp_ffi

rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android
rustup target add aarch64-apple-ios x86_64-apple-ios
rustup target add x86_64-pc-windows-gnu
rustup target add x86_64-apple-darwin aarch64-apple-darwin

# Install cargo-lipo (ios building) and cargo-ndk (android building)

cargo install cargo-lipo
cargo install cargo-ndk

# Install cbindgen (for .h file on iOS)

cargo install cbindgen

# Generate iOS static library

cargo lipo --release

# Generate android

cargo ndk -t armeabi-v7a -t arm64-v8a -t x86_64 -t x86 build --release

# Generate windows

cargo build --target x86_64-pc-windows-gnu --release

# Generate macOS

cargo build --target x86_64-apple-darwin --release
cargo build --target x86_64-apple-darwin --release

# Generate C header

if [ -f target/bindings.h ]; then rm target/bindings.h; fi
cbindgen ./src/lib.rs -c cbindgen.toml | grep -v \#include | uniq >> target/bindings.h

# Copy each Android library to its respective directory
cp target/aarch64-linux-android/release/libxotp_ffi.so ../dotp_native/android/src/main/jniLibs/arm64-v8a/libxotp_ffi.so
cp target/armv7-linux-androideabi/release/libxotp_ffi.so ../dotp_native/android/src/main/jniLibs/armeabi-v7a/libxotp_ffi.so
cp target/i686-linux-android/release/libxotp_ffi.so ../dotp_native/android/src/main/jniLibs/x86/libxotp_ffi.so
cp target/x86_64-linux-android/release/libxotp_ffi.so ../dotp_native/android/src/main/jniLibs/x86_64/libxotp_ffi.so

# Copy the iOS Library and header file
cp target/universal/release/libxotp_ffi.a ../dotp_native/ios/libxotp_ffi.a
cp target/bindings.h ../dotp_native/ios/Classes/xotp_bindings.h

# Copy the Windows DLL to its respective directory
cp target/x86_64-pc-windows-gnu/release/xotp_ffi.dll ../dotp_native/windows/native/xotp_ffi.dll

# Create a macOS FAT library and copy it to the respective directory
if [ -d target/universal-apple-darwin ]; then rm -rf target/universal-apple-darwin; fi
mkdir target/universal-apple-darwin
lipo -create target/x86_64-apple-darwin/release/libxotp_ffi.a target/aarch64-apple-darwin/release/libxotp_ffi.a -output target/universal-apple-darwin/libxotp_ffi.a
cp target/universal-apple-darwin/libxotp_ffi.a ../dotp_native/macos/libxotp_ffi.a
cp target/bindings.h ../dotp_native/macos/Classes/xotp_bindings.h
