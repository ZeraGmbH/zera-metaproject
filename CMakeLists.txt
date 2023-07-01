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
set(path other)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

set(name fontawesome-qml)
set(path other)
set(deps SortFilterProxyModel)
add_sub_project_deps(${name} ${path} "deps")

set(name zfpgatester)
set(deps simple-parser)
add_sub_project_deps(${name} . "deps")

set(name vein-framework)
set(deps )
add_sub_project_deps(${name} . "deps")

set(name vf-crypto-bridge)
set(deps vein-framework)
add_sub_project_deps(${name} . "deps")

set(name vf-cpp)
set(deps vein-framework)
add_sub_project_deps(${name} . "deps")

set(name vf-debugger)
set(deps vein-framework vf-cpp)
add_sub_project_deps(${name} . "deps")


#project vf-unittest2
#set(name vf-unittest2)
#set(path utils)
#set(deps vein-framework vf-logger)
#add_sub_project_deps(${name} ${path} "deps")


#Backend
#########

#libs

#project pythonscriptinginterface
set(name PythonScriptingInterface)
set(path backend/extern)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

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
set(deps vf-cpp PythonScriptingInterface vein-framework vf-logger)
add_sub_project_deps(${name} . "deps")

set(name vf-files)
set(deps vf-cpp)
add_sub_project_deps(${name} . "deps")

#Frontend
#########

#libs

#project vf-gui-translation
set(name vf-gui-translation)
set(path frontend/libs)
set(deps)
add_sub_project_deps(${name} ${path} "deps")

#project vf-qmllibs
set(name vf-qmllibs)
set(path frontend/libs)
set(deps SortFilterProxyModel vf-gui-translation)
add_sub_project_deps(${name} ${path} "deps")

#applications

#project zera-setup2
#set(name zera-setup2)
#set(path frontend/guis)
#set(deps vein-framework vf-logger)
#add_sub_project_deps(${name} ${path} "deps")

#project vf-declarative-gui
set(name vf-declarative-gui)
set(path frontend/guis)
set(deps vf-gui-translation vein-framework vf-logger vf-qmllibs zera-json-helpers)
add_sub_project_deps(${name} ${path} "deps")

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
set(deps zenux-core zera-microcontroller vf-cpp zera-scpi vein-framework zera-json-helpers)
add_sub_project_deps(${name} . "deps")


set(name zera-resourcemanager)
list(APPEND deps zera-scpi zera-classes)
add_sub_project_deps(${name} . "deps")


#project zera-resource-viewer
set(name zera-resource-viewer)
set(path other/utils)
set(deps zera-scpi)
add_sub_project_deps(${name} ${path} "deps")

set(name zenux-services)
set(deps zera-scpi zera-classes)
add_sub_project_deps(${name} . "deps")

