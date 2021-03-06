#
# CMakeIt - a collection of CMake modules to build programs from 'Visual Studio'-like 
# projects, and well-structure project layouts (public and private include folders,
# source folders), using CMake build system. Also features pre compiled headers
# support, unit tests, installation ('make install' style), packaging, etc.
#
# Copyright (C) 2013, Fornazin & Fornazin Consultoria em Informática Ltda
#
# This library is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software 
# Foundation; either version 3 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT ANY 
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
# PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along 
# with this library; if not, please write to the Free Software Foundation, Inc., 
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

#
# cmakeit_build_type_detection.cmake - detect build type (debug, release with debug info, release)
#

if(NOT CMAKEIT_HIDE_BANNER)
	message(STATUS "Detecting target plataform for building...")
endif()

if((CMAKE_SYSTEM_NAME STREQUAL "WindowsStore") OR CYGWIN OR WIN32 OR MINGW OR CMAKE_VS_PLATFORM_NAME)

	set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_WINDOWS})

	if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_WINDOWS_UWP})
	elseif(CYGWIN)
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_WINDOWS_CYGWIN})
	elseif(WIN32 OR MINGW OR CMAKE_VS_PLATFORM_NAME)
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_WINDOWS_WINDOWS_API})
	endif()

elseif(CMAKE_OSX_DEPLOYMENT_TARGET OR APPLE)

	set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_UNIX})

	if(CMAKE_OSX_SYSROOT)

		string(REGEX MATCH "iphoneos" INTERNAL_CMAKEIT_DETECT_APPLE_IOS ${CMAKE_OSX_SYSROOT})
		string(REGEX MATCH "iphonesimulator" INTERNAL_CMAKEIT_DETECT_APPLE_IOS_SIMULATOR ${CMAKE_OSX_SYSROOT})
		string(REGEX MATCH "appletvos" INTERNAL_CMAKEIT_DETECT_APPLE_TVOS ${CMAKE_OSX_SYSROOT})
		string(REGEX MATCH "appletvsimulator" INTERNAL_CMAKEIT_DETECT_APPLE_TVOS_SIMULATOR ${CMAKE_OSX_SYSROOT})
		string(REGEX MATCH "watchos" INTERNAL_CMAKEIT_DETECT_APPLE_WATCHOS ${CMAKE_OSX_SYSROOT})
		string(REGEX MATCH "watchsimulator" INTERNAL_CMAKEIT_DETECT_APPLE_WATCHOS_SIMULATOR ${CMAKE_OSX_SYSROOT})

		if(INTERNAL_CMAKEIT_DETECT_APPLE_IOS)

			set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_APPLE_IOS})

			unset(INTERNAL_CMAKEIT_DETECT_APPLE_IOS)

		endif()

		if(INTERNAL_CMAKEIT_DETECT_APPLE_IOS_SIMULATOR)

			set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_APPLE_IOS_SIMULATOR})

			unset(INTERNAL_CMAKEIT_DETECT_APPLE_IOS_SIMULATOR)

		endif()

		if(INTERNAL_CMAKEIT_DETECT_APPLE_TVOS)

			set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_APPLE_TVOS})

			unset(INTERNAL_CMAKEIT_DETECT_APPLE_TVOS)

		endif()

		if(INTERNAL_CMAKEIT_DETECT_APPLE_TVOS_SIMULATOR)

			set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_APPLE_TVOS_SIMULATOR})

			unset(INTERNAL_CMAKEIT_DETECT_APPLE_TVOS_SIMULATOR)

		endif()

		if(INTERNAL_CMAKEIT_DETECT_APPLE_WATCHOS)

			set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_APPLE_WATCHOS})

			unset(INTERNAL_CMAKEIT_DETECT_APPLE_WATCHOS)

		endif()

		if(INTERNAL_CMAKEIT_DETECT_APPLE_WATCHOS_SIMULATOR)

			set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_APPLE_WATCHOS_SIMULATOR})

			unset(INTERNAL_CMAKEIT_DETECT_APPLE_WATCHOS_SIMULATOR)

		endif()
	endif()

	if(NOT CMAKEIT_TARGET_PLATFORM_VARIANT)
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_APPLE_MACOS})
	endif()

elseif(QNXNTO)

	set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_UNIX})
	set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_QNX})

elseif(CMAKE_SYSTEM_NAME STREQUAL "Android")

	set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_UNIX})
	set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_ANDROID})

else()

	string(REGEX MATCH "Linux" INTERNAL_CMAKEIT_DETECT_OS_LINUX ${CMAKE_SYSTEM_NAME})
	string(REGEX MATCH "BSD" INTERNAL_CMAKEIT_DETECT_OS_BSD ${CMAKE_SYSTEM_NAME})
	string(REGEX MATCH "SunOS" INTERNAL_CMAKEIT_DETECT_OS_SUNOS ${CMAKE_SYSTEM_NAME})
	string(REGEX MATCH "emcc" INTERNAL_CMAKEIT_DETECT_WEBASSEMBLY ${CMAKE_CXX_COMPILER})

	if(INTERNAL_CMAKEIT_DETECT_OS_LINUX)

		set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_UNIX})
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_LINUX})

		unset(INTERNAL_CMAKEIT_DETECT_OS_LINUX)

	endif()
	
	if(INTERNAL_CMAKEIT_DETECT_OS_BSD)

		set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_UNIX})
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_BSD})

		unset(INTERNAL_CMAKEIT_DETECT_OS_BSD)

	endif()
	
	if(INTERNAL_CMAKEIT_DETECT_OS_SUNOS)

		set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_UNIX})
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNIX_SUNOS})

		unset(INTERNAL_CMAKEIT_DETECT_OS_SUNOS)

	endif()
	
	if(INTERNAL_CMAKEIT_DETECT_WEBASSEMBLY)

		set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_WEBASSEMBLY})
		set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_WEBASSEMBLY_BROWSER})

		unset(INTERNAL_CMAKEIT_DETECT_WEBASSEMBLY)
		
	endif()

endif()

if(NOT CMAKEIT_TARGET_PLATFORM)
	set(CMAKEIT_TARGET_PLATFORM ${CMAKEIT_TARGET_PLATFORM_UNSPECIFIED})
endif()

if(NOT CMAKEIT_TARGET_PLATFORM_VARIANT)
	set(CMAKEIT_TARGET_PLATFORM_VARIANT ${CMAKEIT_TARGET_PLATFORM_VARIANT_UNSPECIFIED})
endif()
