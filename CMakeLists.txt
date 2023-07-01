cmake_minimum_required(VERSION 3.6)

#set project name and language
project(zera-metaproject LANGUAGES CXX)

#Automoc and RCC ON. Needed in QT projects
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)

include(ZeraSuperBuild.cmake)

#activate QML Debugging if build type is Debug
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "QML Debugging is enabled. Please use this build only in a safe environment")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DQT_QML_DEBUG -DQT_DECLARATIVE_DEBUG")
endif()


#general
##########

# place libs everything can depend on here

set(name zenux-core)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name zera-microcontroller)
set(deps zenux-core)
add_sub_project_deps(${name} . "deps")

set(name zera-json-helpers)
set(deps)
add_sub_project_deps(${name} . "deps")

set(name simple-parser)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name SortFilterProxyModel)
set(path extern)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

set(name fontawesome-qml)
set(deps SortFilterProxyModel)
add_sub_project_deps(${name} . "deps")

set(name zfpgatester)
set(deps simple-parser)
add_sub_project_deps(${name} . "deps")

set(name vein-framework)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name vf-crypto-bridge)
set(deps vein-framework)
add_sub_project_deps(${name} . "deps")

set(name vf-debugger)
set(deps vein-framework)
add_sub_project_deps(${name} . "deps")


#project vf-unittest2
#set(name vf-unittest2)
#set(path utils)
#set(deps vein-framework vf-logger)
#add_sub_project_deps(${name} ${path} "deps")


#Backend
#########

#libs

set(name python-scripting-interface)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name qtiohelper)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name vf-script)
set(deps vein-framework)
add_sub_project_deps(${name} . "deps")


set(name vf-logger)
set(deps vein-framework)
add_sub_project_deps(${name} . "deps")


set(name vf-export)
set(deps vein-framework python-scripting-interface vf-logger)
add_sub_project_deps(${name} . "deps")

set(name vf-files)
set(deps vein-framework)
add_sub_project_deps(${name} . "deps")

set(name vf-gui-translation)
set(deps)
add_sub_project_deps(${name} . "deps")

set(name vf-qmllibs)
set(deps SortFilterProxyModel vf-gui-translation)
add_sub_project_deps(${name} . "deps")

set(name vf-declarative-gui)
set(deps vf-gui-translation vein-framework vf-logger vf-qmllibs zera-json-helpers)
add_sub_project_deps(${name} . "deps")

#project vf-database-recorder
set(name vf-database-recorder)
set(path other/utils)
set(deps vein-framework vf-logger)
add_sub_project_deps(${name} ${path} "deps")


#project vf-database-replay
set(name vf-database-replay)
set(path other/utils)
set(deps vein-framework vf-logger)
add_sub_project_deps(${name} ${path} "deps")

set(name zera-scpi)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name bridgefmtspihelper)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name zera-classes)
set(deps zenux-core zera-microcontroller zera-scpi vein-framework zera-json-helpers)
add_sub_project_deps(${name} . "deps")


set(name zera-resourcemanager)
list(APPEND deps zera-scpi zera-classes)
add_sub_project_deps(${name} . "deps")


set(name zera-resource-viewer)
set(deps zera-scpi)
add_sub_project_deps(${name} . "deps")

set(name zenux-services)
set(deps zera-scpi zera-classes)
add_sub_project_deps(${name} . "deps")

