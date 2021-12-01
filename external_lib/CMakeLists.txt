cmake_minimum_required(VERSION 3.14)
project(extlib LANGUAGES OBJC)

set(CMAKE_XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.kambala.test.$(PRODUCT_NAME)")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED NO)

add_library(${PROJECT_NAME} SHARED
	extlib.h
	extlib.m
)
set_target_properties(${PROJECT_NAME} PROPERTIES
	PUBLIC_HEADER extlib.h
)
target_link_libraries(${PROJECT_NAME} PRIVATE
	"-framework Foundation"
	"-framework StoreKit"
)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
	LIBRARY
	PUBLIC_HEADER
)
