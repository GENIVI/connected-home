#include <QGuiApplication>
#include <QQuickView>

//
// Define IVI surface for application
//
// Use a well-known surface ID from an existing POC app
// or ensure your surface ID is known to the Layer Manager
//
// Known surface IDs & corresponding PoC apps:
// 3    - QML Example
// 20   - AudioManager Monitor
// 30   - Browser PoC
// 40   - Fuel Service Advisor PoC
// 10   - Mock Navigation PoC
// 5100 - MediaPlayer PoC

#define CONNECTED_HOME_SURFACE_ID 10

int main(int argc, char *argv[])
{
//    setenv("QT_QPA_PLATFORM", "wayland", 1); // force to use wayland plugin
//    setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", 1);

    QGuiApplication app(argc, argv);

    // Use QQuickView to load your base QML view
    QQuickView view(QUrl(QStringLiteral("qrc:/main.qml")));

    // Set the surface ID
    view.setProperty("IVI-Surface-ID", CONNECTED_HOME_SURFACE_ID);

    // Display the QML
    view.show();

    return app.exec();
}
