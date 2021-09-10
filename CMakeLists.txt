cmake_minimum_required(VERSION 3.6)

#set project name and language
project(vf-metaproject LANGUAGES CXX)

#Automoc and RCC ON. Needed in QT projects
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)
#C++ 11 Flag
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)




include(ZeraSuperBuild.cmake)


#activate QML Debugging if build type is Debug
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "QML Debugging is enabled. Please use this build only in a dafe environment")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DQT_QML_DEBUG -DQT_DECLARATIVE_DEBUG")
endif()


#general
##########

# place libs everything can depend on here




#middleware
###########

#libs

#Project vf-helpers
set(name helpers)
set(path middleware/utils)
set(deps)
add_sub_project_deps(${name} ${path} "deps")


#project vf-tcp
set(name vf-tcp)
set(path middleware/transport)
set(deps helpers)
add_sub_project_deps(${name} ${path} "deps")


#project xiqnet
set(name xiqnet)
set(path middleware/transport)
set(deps helpers)
add_sub_project_deps(${name} ${path} "deps")

#project vf-crypto-bridge
set(name vf-crypto-bridge)
set(path middleware/utils)
set(deps helpers vf-tcp)
add_sub_project_deps(${name} ${path} "deps")


#project vf-event
set(name vf-event)
set(path middleware/processing)
set(deps helpers vf-tcp)
add_sub_project_deps(${name} ${path} "deps")

#project vf-component
set(name vf-component)
set(path middleware/processing)
set(deps helpers vf-tcp vf-event)
add_sub_project_deps(${name} ${path} "deps")

#project vf-storage-hash
set(name vf-storage-hash)
set(path middleware/storage)
set(deps vf-component vf-event helpers)
add_sub_project_deps(${name} ${path} "deps")

#project vf-net2
set(name vf-net2)
set(path middleware/transport)
set(deps vf-tcp helpers vf-component vf-event)
add_sub_project_deps(${name} ${path} "deps")

#project vf-protobuf
set(name vf-protobuf)
set(path middleware/transport)
add_sub_project_deps(${name} ${path} "deps")

#project vf-qml
set(name vf-qml)
set(path middleware/api)
set(deps vf-protobuf vf-net2 helpers vf-event)
add_sub_project_deps(${name} ${path} "deps")

#project vf-cpp
set(name vf-cpp)
set(path middleware/api)
set(deps vf-component helpers vf-event)
add_sub_project_deps(${name} ${path} "deps")

#applications

#project debugger
set(name debugger)
set(path middleware/utils)
set(deps vf-tcp helpers vf-component vf-event)
add_sub_project_deps(${name} ${path} "deps")


#project vf-unittest2
#set(name vf-unittest2)
#set(path utils)
#set(deps vf-tcp helpers vf-component vf-event vf-logger)
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
set(deps vf-protobuf vf-net2 helpers vf-event vf-qml vf-storage-hash)
add_sub_project_deps(${name} ${path} "deps")


#project vf-logger
set(name vf-logger)
set(path backend/processing)
set(deps vf-tcp helpers vf-component vf-event vf-qml vf-storage-hash)
add_sub_project_deps(${name} ${path} "deps")


#project vf-database-replay
set(name vf-export)
set(path backend/processing)
set(deps vf-cpp PythonScriptingInterface helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")

#project vf-files
set(name vf-files)
set(path backend/processing)
set(deps vf-cpp)
add_sub_project_deps(${name} ${path} "deps")

#Frontend
#########

#libs

#Project zvkeyboard
set(name zvkeyboard)
set(path frontend/libs)
set(deps)
add_sub_project_deps(${name} ${path} "deps")

#project JsonSettingsQml
set(name JsonSettingsQml)
set(path frontend/libs)
set(deps)
add_sub_project_deps(${name} ${path} "deps")

#project vf-gui-translation
set(name vf-gui-translation)
set(path frontend/libs)
set(deps)
add_sub_project_deps(${name} ${path} "deps")

#project SortFilterProxyModelCmake
set(name SortFilterProxyModelCmake)
set(path frontend/libs)
set(deps)
add_sub_project_deps(${name} ${path} "deps")

#project vf-qmllibs
set(name vf-qmllibs)
set(path frontend/libs)
set(deps SortFilterProxyModelCmake JsonSettingsQml vf-gui-translation)
add_sub_project_deps(${name} ${path} "deps")

#applications

#project zera-setup2
set(name zera-setup2)
set(path frontend/guis)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")

#project vf-declarative-gui
set(name vf-declarative-gui)
set(path frontend/guis)
set(deps vf-tcp vf-gui-translation helpers vf-component vf-event vf-logger vf-qmllibs)
add_sub_project_deps(${name} ${path} "deps")

#project vf-database-recorder
set(name vf-database-recorder)
set(path other/utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")


#project vf-database-replay
set(name vf-database-replay)
set(path other/utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")




##zera-libs-and-services

##Libs
#project zera-scpi
set(name zera-scpi)
set(path backend/libs)
set(deps )
add_sub_project_deps(${name} ${path} "deps")

#project zera-resourcemanager-protobuf
set(name zera-resourcemanager-protobuf)
set(path backend/libs)
set(deps zera-scpi)
add_sub_project_deps(${name} ${path} "deps")

#project zera-classes
set(name zera-classes)
set(path backend/libs)
set(deps zera-scpi zera-resourcemanager-protobuf xiqnet vf-component helpers vf-event)
add_sub_project_deps(${name} ${path} "deps")


##Applications
set(name zera-resourcemanager)
set(path backend/applications)
list(APPEND deps zera-scpi zera-resourcemanager-protobuf zera-classes)
add_sub_project_deps(${name} ${path} "deps")

#project zera-modulemanager
set(name zera-modulemanager)
set(path backend/applications)
set(deps zera-scpi zera-resourcemanager-protobuf zera-classes vf-component helpers vf-event)
add_sub_project_deps(${name} ${path} "deps")



##Services

#project com5003d
set(name com5003d)
set(path backend/services)
set(deps zera-scpi zera-resourcemanager-protobuf zera-classes)
add_sub_project_deps(${name} ${path} "deps")

#project sec1000d
set(name sec1000d)
set(path backend/services)
set(deps zera-scpi zera-resourcemanager-protobuf zera-classes)
add_sub_project_deps(${name} ${path} "deps")

#project zdsp1d
set(name zdsp1d)
set(path backend/services)
set(deps zera-scpi zera-resourcemanager-protobuf zera-classes)
add_sub_project_deps(${name} ${path} "deps")

#project mt310s2d
set(name mt310s2d)
set(path backend/services)
set(deps zera-scpi zera-resourcemanager-protobuf zera-classes)
add_sub_project_deps(${name} ${path} "deps")

#project wm3000id
set(name wm3000id)
set(path backend/services)
set(deps zera-classes)
add_sub_project_deps(${name} ${path} "deps")

#project wm3000ud
set(name wm3000ud)
set(path backend/services)
set(deps zera-classes)
add_sub_project_deps(${name} ${path} "deps")


























































