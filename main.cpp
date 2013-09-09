#include <QtGui/QGuiApplication>

#include "box2dplugin.h"
#include "qtquick2applicationviewer.h"

extern void registryTypes ();
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    registryTypes ();

    Box2DPlugin plugin;
    plugin.registerTypes("Box2D");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/Arkanoid/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
