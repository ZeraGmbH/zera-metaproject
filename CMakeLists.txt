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
set(path backend/libs)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

set(name zera-microcontroller)
set(path backend/libs)
set(deps zenux-core)
add_sub_project_deps(${name} ${path} "deps")

set(name zera-json-helpers)
set(path other)
set(deps)
add_sub_project_deps(${name} ${path} "deps")

set(name simple-parser)
set(path other)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

set(name SortFilterProxyModel)
set(path other)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

set(name fontawesome-qml)
set(path other)
set(deps SortFilterProxyModel)
add_sub_project_deps(${name} ${path} "deps")

set(name zfpgatester)
set(path other/applications)
set(deps simple-parser)
add_sub_project_deps(${name} ${path} "deps")


#middleware
###########

#libs

#project vein-framework
set(name vein-framework)
set(path middleware)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

#project vf-tcp
set(name vf-tcp)
set(path middleware/transport)
set(deps vein-framework)
add_sub_project_deps(${name} ${path} "deps")


#project xiqnet
set(name xiqnet)
set(path middleware/transport)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

#project vf-crypto-bridge
set(name vf-crypto-bridge)
set(path middleware/utils)
set(deps vein-framework vf-tcp)
add_sub_project_deps(${name} ${path} "deps")



#project vf-net2
set(name vf-net2)
set(path middleware/transport)
set(deps vein-framework vf-tcp)
add_sub_project_deps(${name} ${path} "deps")

#project vf-qml
set(name vf-qml)
set(path middleware/api)
set(deps vein-framework vf-net2)
add_sub_project_deps(${name} ${path} "deps")

#project vf-cpp
set(name vf-cpp)
set(path middleware/api)
set(deps vein-framework)
add_sub_project_deps(${name} ${path} "deps")

#applications

#project debugger
set(name debugger)
set(path middleware/utils)
set(deps vein-framework vf-tcp vf-qml vf-cpp)
add_sub_project_deps(${name} ${path} "deps")


#project vf-unittest2
#set(name vf-unittest2)
#set(path utils)
#set(deps vein-framework vf-tcp vf-logger)
#add_sub_project_deps(${name} ${path} "deps")


#Backend
#########

#libs

#project pythonscriptinginterface
set(name PythonScriptingInterface)
set(path backend/extern)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

#project qtiohelper
set(name qtiohelper)
set(path backend/libs)
set(deps )
add_sub_project_deps(${name} ${path} "deps")


#modules

#project vf-script
set(name vf-script)
set(path backend/processing)
set(deps vf-net2 vein-framework vf-qml)
add_sub_project_deps(${name} ${path} "deps")


#project vf-logger
set(name vf-logger)
set(path backend/processing)
set(deps vf-tcp vein-framework vf-qml)
add_sub_project_deps(${name} ${path} "deps")


#project vf-database-replay
set(name vf-export)
set(path backend/processing)
set(deps vf-cpp PythonScriptingInterface vein-framework vf-logger)
add_sub_project_deps(${name} ${path} "deps")

#project vf-files
set(name vf-files)
set(path backend/processing)
set(deps vf-cpp)
add_sub_project_deps(${name} ${path} "deps")

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
#set(deps vf-tcp vein-framework vf-logger)
#add_sub_project_deps(${name} ${path} "deps")

#project vf-declarative-gui
set(name vf-declarative-gui)
set(path frontend/guis)
set(deps vf-tcp vf-gui-translation vein-framework vf-logger vf-qmllibs zera-json-helpers)
add_sub_project_deps(${name} ${path} "deps")

#project vf-database-recorder
set(name vf-database-recorder)
set(path other/utils)
set(deps vf-tcp vein-framework vf-logger)
add_sub_project_deps(${name} ${path} "deps")


#project vf-database-replay
set(name vf-database-replay)
set(path other/utils)
set(deps vf-tcp vein-framework vf-logger)
add_sub_project_deps(${name} ${path} "deps")


##zera-libs-and-services

##Libs
#project zera-scpi
set(name zera-scpi)
set(path backend/libs)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

#project bridgefmtspihelper
set(name bridgefmtspihelper)
set(path backend/libs)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

#project zera-classes
set(name zera-classes)
set(path backend/libs)
set(deps zenux-core zera-microcontroller vf-cpp zera-scpi xiqnet vein-framework zera-json-helpers)
add_sub_project_deps(${name} ${path} "deps")


##Applications
set(name zera-resourcemanager)
set(path backend/applications)
list(APPEND deps zera-scpi zera-classes)
add_sub_project_deps(${name} ${path} "deps")


#project zera-resource-viewer
set(name zera-resource-viewer)
set(path other/utils)
set(deps zera-scpi)
add_sub_project_deps(${name} ${path} "deps")


##Services

set(name zenux-services)
set(path backend/services)
set(deps zera-scpi zera-classes)
add_sub_project_deps(${name} ${path} "deps")

