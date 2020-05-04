cmake_minimum_required(VERSION 2.8.3)

project(openmesh)

find_package(catkin REQUIRED COMPONENTS mk)

set(VERSION 6.3)

# To avoid catkin_package() error: "directory not exist"
make_directory(${CATKIN_DEVEL_PREFIX}/include/openmesh)

catkin_package(
  DEPENDS
  CATKIN_DEPENDS
  INCLUDE_DIRS ${CATKIN_DEVEL_PREFIX}/include/openmesh
  LIBRARIES OpenMeshCore OpenMeshTools
)

add_custom_target(
  build_openmesh ALL
  COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/tmp
  COMMAND cmake -E chdir ${CMAKE_CURRENT_BINARY_DIR} make -f ${PROJECT_SOURCE_DIR}/Makefile INSTALL_DIR=${CMAKE_CURRENT_BINARY_DIR}/tmp MD5SUM_FILE=${PROJECT_SOURCE_DIR}/build/OpenMesh-${VERSION}.tar.gz.md5sum
  # copy include files
  COMMAND mkdir -p  ${CATKIN_DEVEL_PREFIX}/include/openmesh
  COMMAND cp -r ${CMAKE_CURRENT_BINARY_DIR}/tmp/include/OpenMesh ${CATKIN_DEVEL_PREFIX}/include/openmesh
  # copy lib files
  COMMAND cp -a ${CMAKE_CURRENT_BINARY_DIR}/tmp/lib/*.so* ${CATKIN_DEVEL_PREFIX}/lib/
)

install(
  DIRECTORY ${CATKIN_DEVEL_PREFIX}/include/openmesh/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)

install(
  DIRECTORY ${CATKIN_DEVEL_PREFIX}/lib/
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)
