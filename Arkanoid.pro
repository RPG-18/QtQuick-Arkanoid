# Add more folders to ship with the application, here
folder_01.source = qml/Arkanoid
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
QMAKE_CXXFLAGS += -std=c++11

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    registryTypes.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(3rdparty/qml-box2d/box2d-static.pri)
include(components/components.pri)
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/Arkanoid/Game.qml
