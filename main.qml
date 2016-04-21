import QtQuick 2.3
import QtQuick.Window 2.2
import QtLocation 5.3
import QtPositioning 5.2
import QtGraphicalEffects 1.0

Rectangle {
    FontLoader { id: oswald; source: "qrc:/fonts/Oswald-Regular.ttf" }
    FontLoader { id: oswaldItalic; source: "qrc:/fonts/Oswald-RegularItalic.ttf" }

    width: 1920
    height: 1280
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#000e22"
        }

        GradientStop {
            position: 1
            color: "#002456"
        }
    }

    // 'Leaving Home' Button
    Rectangle {
        id: buttonTop
        x: 660
        y: 321
        visible: (comingHomeDisplay.opacity == 1 || smartHomeDisplay.opacity == 1) ? false : true
        width: 600
        height: 200
        color: "#ffffff"
        radius: 10
        z: 10
        MouseArea {
            id: mouseAreaTop
            onClicked: { leavingDisplay.stateVisible = true }
            width: 600
            height: 200
            z: 10
        }

        Text {
            id: textTop
            anchors.centerIn: parent
            text: qsTr("Leaving Home")
            font.family: oswald.name
            font.pixelSize: 60
        }
    }

    // 'Coming Home' Button
    Rectangle {
        id: buttonMiddle
        x: 660
        y: 540
        visible: (comingHomeDisplay.opacity == 1 || smartHomeDisplay.opacity == 1) ? false : true
        width: 600
        height: 200
        color: "#ffffff"
        radius: 10
        z: 10
        MouseArea {
            id: mouseAreaMiddle
            onClicked: {
                leavingDisplay.stateVisible = false
                comingHomeDisplay.stateVisible = true
                comingHomeDisplay.z = 20
            }
            width: 600
            height: 200
            z: 10
        }

        Text {
            id: textMiddle
            anchors.centerIn: parent
            text: qsTr("Coming Home")
            font.family: oswald.name
            font.pixelSize: 60
        }
    }

    // 'Smart Home Status' Button
    Rectangle {
        id: buttonBottom
        x: 660
        y: 760
        visible: (comingHomeDisplay.opacity == 1 || smartHomeDisplay.opacity == 1) ? false : true
        width: 600
        height: 200
        color: "#ffffff"
        radius: 10
        z: 10
        MouseArea {
            id: mouseAreaBottom
            onClicked: {
                leavingDisplay.stateVisible = false
                comingHomeDisplay.stateVisible = false
                smartHomeDisplay.stateVisible = true
                smartHomeDisplay.z = 20
            }
            width: 600
            height: 200
            z: 10
        }

        Text {
            id: textBottom
            anchors.centerIn: parent
            text: qsTr("Smart Home Status")
            font.family: oswald.name
            font.pixelSize: 60
        }
    }

    // Display a notification that tells the user the vehicle is moving.
    Rectangle {
        id: leavingDisplay
        property bool stateVisible: false

        states: [
            State { when: leavingDisplay.stateVisible;
                    PropertyChanges {   target: leavingDisplay; opacity: 1.0    }},
            State { when: !leavingDisplay.stateVisible;
                    PropertyChanges {   target: leavingDisplay; opacity: 0.0    }}
        ]
        transitions: [ Transition { NumberAnimation { property: "opacity"; duration: 200}} ]

        opacity: 0
        x: 560
        y: 134
        width: 800
        height: 80
        color: "#c7dfad"
        radius: 10
        border.width: 0

        Text {
            id: leavingText
            anchors.centerIn: parent
            text: qsTr("Vehicle Moving")
            font.family: oswaldItalic.name
            font.pixelSize: 40
        }
    }

    // Shows a map of "current location" and a route home. For demo purposes, this is a hard coded image.
    // There's some Anson magic that will be shown in the empty box underneath the map.
    Rectangle {
        id: comingHomeDisplay
        property bool stateVisible: false

        states: [
            State {
                when: comingHomeDisplay.stateVisible;
                PropertyChanges { target: comingHomeDisplay; opacity: 1.0 }
                PropertyChanges { target: comingHomeDisplay; z: 100 }

            },
            State {
                when: !comingHomeDisplay.stateVisible;
                PropertyChanges { target: comingHomeDisplay; opacity: 0.0 }
                PropertyChanges { target: comingHomeDisplay; z: -1 }
            }
        ]
        transitions: [ Transition { NumberAnimation { property: "opacity"; duration: 200}} ]

        opacity: 0
        anchors.centerIn: parent
        width: 1050
        height: 1050
        color: "#000e22"
        radius: 10
        AnimatedImage {
            id: mapAnimation
            anchors.centerIn: parent
            width: 1050
            height: 450
            source: "qrc:/img/15-Waypoint-Map-Animation-25.gif"
            playing: (comingHomeDisplay.opacity == 1) ? true : false
        }

        Image {
            id: closeComingHome
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: 50
            height: 50
            source: "qrc:/img/close-button.png"
            MouseArea {
                id: mouseAreaCloseComingHome
                onClicked: { comingHomeDisplay.stateVisible = false; comingHomeDisplay.z = 0 }
                x: 0
                y: 0
                width: 50
                height: 50
            }
        }
    }

    // This holds the 'Smart Home Status' information that will come from Anson magic. May be hard coded for demo purposes, we'll see.
    Rectangle {
        id: smartHomeDisplay
        property bool stateVisible: false

        states: [
            State { when: smartHomeDisplay.stateVisible;
                    PropertyChanges {   target: smartHomeDisplay; opacity: 1.0    }},
            State { when: !smartHomeDisplay.stateVisible;
                    PropertyChanges {   target: smartHomeDisplay; opacity: 0.0    }}
        ]
        transitions: [ Transition { NumberAnimation { property: "opacity"; duration: 200}} ]

        opacity: 0
        anchors.centerIn: parent
        width: 1050
        height: 800
        color: "#000e22"
        radius: 10
        AnimatedImage {
            id: loadingAnimation
            anchors.centerIn: parent
            width: 100
            height: 100
            source: "qrc:/img/loading-animation.gif"
        }
        Image {
            id: closeSmartHome
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: 50
            height: 50
            source: "qrc:/img/close-button.png"
            MouseArea {
                id: mouseAreaCloseSmartHome
                onClicked: { smartHomeDisplay.stateVisible = false; smartHomeDisplay.z = 0 }
                x: 0
                y: 0
                width: 50
                height: 50
            }
        }
    }

    // GENIVI and Open Connectivity Foundation Logos

    Image {
        id: logoGenivi
        x: 10
        y: 10
        height: 140
        width: 160
        z: 13
        source: "qrc:/img/genivi-logo.png"
    }

    Image {
        id: logoOCF
        x: 205
        y: 10
        height: 140
        width: 284
        z: 12
        source: "qrc:/img/ocf-logo.png"
    }
}
