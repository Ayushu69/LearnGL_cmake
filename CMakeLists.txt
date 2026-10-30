cmake_minimum_required(VERSION 3.15)
project(LearnGL C CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# GLFW: downloaded + built for you
include(FetchContent)
FetchContent_Declare(glfw GIT_REPOSITORY https://github.com/glfw/glfw.git GIT_TAG 3.4)
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(glfw)

# GLAD
add_library(glad deps/glad/src/glad.c)
target_include_directories(glad PUBLIC deps/glad/include)

# Shader class
add_library(shader src/shaders.cpp)
target_include_directories(shader PUBLIC src)
target_link_libraries(shader PUBLIC glad)

# copy shaders next to the exes, on every build
add_custom_target(copy_shaders ALL
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${CMAKE_SOURCE_DIR}/shaders ${CMAKE_BINARY_DIR}/shaders)

# one line per demo
function(add_demo name)
  add_executable(${name} src/${name}.cpp)
  target_link_libraries(${name} PRIVATE shader glfw glad)
  add_dependencies(${name} copy_shaders)
endfunction()


#add_demo(tutorial)
add_demo(practice_hello_tri)
add_demo(shaders_tutorial)