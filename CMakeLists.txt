cmake_minimum_required(VERSION 3.16)
project(test LANGUAGES OBJC)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(CMAKE_XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.kambala.test.$(PRODUCT_NAME)")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED NO)
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED_FOR_APPS YES)

find_library(EXTLIB_LIBRARY extlib
	REQUIRED
	NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH
)
find_path(EXTLIB_INCLUDE extlib.h
	REQUIRED
	NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH
)

add_library(mylib SHARED
	lib.h
	lib.m
)
target_include_directories(mylib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(mylib PUBLIC
	"-framework UIKit"
)

include(MyHelpers)

add_executable(${PROJECT_NAME}
	main.m
)
ConfigureAppTarget(${PROJECT_NAME})
target_include_directories(${PROJECT_NAME} PRIVATE
	${EXTLIB_INCLUDE}
)
target_link_libraries(${PROJECT_NAME} PRIVATE
	mylib
	${EXTLIB_LIBRARY}
)
PackageAppBundle(${PROJECT_NAME} main)

add_executable(OtherApp
	main_other.m
)
ConfigureAppTarget(OtherApp)
target_link_libraries(OtherApp PRIVATE
	mylib
)
PackageAppBundle(OtherApp other)

include(GNUInstallDirs)

set(CMAKE_INSTALL_DATADIR ".")
install(FILES "LICENSE" TYPE DATA COMPONENT other)

set(CMAKE_INSTALL_LIBDIR "Frameworks")
InstallSharedLibraries(${PROJECT_NAME} main)
InstallSharedLibraries(OtherApp other)
