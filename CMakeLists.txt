cmake_minimum_required(VERSION 3.20)

project(opencv-local)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # Generate compile_commands.json

set(BUILD_SHARED_LIBS OFF)
# opencv configuration
set(BUILD_opencv_world ON)
set(BUILD_PERF_TESTS OFF)
set(BUILD_TESTS OFF)
set(BUILD_WITH_STATIC_CRT OFF)
set(WITH_CUDA OFF)
set(WITH_CUFFT OFF)
set(BUILD_EXAMPLES OFF)
set(BUILD_ANDROID_EXAMPLES OFF)
set(BUILD_ANDROID_PROJECTS OFF)
set(INSTALL_ANDROID_EXAMPLES OFF)
set(BUILD_opencv_apps OFF)
set(BUILD_JAVA OFF)
set(BUILD_opencv_python2 OFF)
set(BUILD_opencv_python3 OFF)
set(WITH_PROTOBUF OFF)
set(BUILD_PROTOBUF OFF)
set(OPENCV_DNN_OPENCL OFF)
include(FetchContent)
# opencv
FetchContent_Declare(
  opencv
  GIT_REPOSITORY https://github.com/opencv/opencv.git
  GIT_TAG 4.4.0)
FetchContent_MakeAvailable(opencv)

# Reference: 
# 1. https://www.reddit.com/r/cpp_questions/comments/j3aos8/how_do_i_use_fetchcontent_to_include_opencv/
# 2. https://stackoverflow.com/questions/64156798/including-opencv-with-fetchcontent-does-not-work
# 3. https://github.com/bensanmorris/opencv_for_graphics_programmers/blob/aeed24aa6666a74743fcbed92250ae2549f7701b/CMakeLists.txt
# collect the opencv include dirs
macro(collect_include_dirs result curdir)
    file(GLOB children ${curdir}/*)
    set(dirlist "")
    foreach(child ${children})
        if(IS_DIRECTORY ${child})
            list(APPEND dirlist ${child}/include)
        endif()
    endforeach()
    set(${result} ${dirlist})
endmacro()

collect_include_dirs(OPENCV_INCLUDE_DIRS ${OpenCV_SOURCE_DIR}/modules)
list(APPEND OPENCV_INCLUDE_DIRS ${CMAKE_CURRENT_BINARY_DIR} ${OpenCV_SOURCE_DIR}/include)

add_executable(main main.cpp)
target_link_libraries(main PRIVATE opencv_world)
target_include_directories(main PRIVATE ${OPENCV_INCLUDE_DIRS})
