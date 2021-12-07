function(ConfigureAppTarget target)
	set_target_properties(${target} PROPERTIES
		MACOSX_BUNDLE_GUI_IDENTIFIER "$(PRODUCT_BUNDLE_IDENTIFIER)"
		MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
		MACOSX_BUNDLE_BUNDLE_VERSION "1"
		XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "$(CODE_SIGNING_ALLOWED_FOR_APPS)"
		XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@executable_path/Frameworks"
	)
endfunction()

function(PackageAppBundle target component)
	add_custom_command(TARGET ${target} POST_BUILD
		COMMAND ${CMAKE_COMMAND} --install "${CMAKE_BINARY_DIR}" --config "$<CONFIG>" --component "${component}" --prefix "$<TARGET_BUNDLE_CONTENT_DIR:${target}>"
		COMMAND ${CMAKE_SOURCE_DIR}/apple_codesign.sh
	)
endfunction()

function(InstallSharedLibraries target component)
	get_target_property(LINKED_LIBS ${target} LINK_LIBRARIES)
	foreach(LINKED_LIB IN LISTS LINKED_LIBS)
		if(TARGET ${LINKED_LIB})
			get_target_property(LIB_TYPE ${LINKED_LIB} TYPE)
			if(LIB_TYPE STREQUAL "SHARED_LIBRARY")
				install(TARGETS ${LINKED_LIB} LIBRARY COMPONENT ${component})
			endif()
		else()
			if(LINKED_LIB MATCHES "\\${CMAKE_SHARED_LIBRARY_SUFFIX}$")
				install(FILES ${LINKED_LIB} TYPE LIB COMPONENT ${component})
			endif()
		endif()
	endforeach()
endfunction()
