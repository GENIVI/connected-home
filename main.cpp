#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    setenv("QT_QPA_PLATFORM", "wayland", 1); // force to use wayland plugin
    setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", 1);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
