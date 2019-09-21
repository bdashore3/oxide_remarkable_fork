import QtQuick 2.9

Item {
    id: root
    clip: true
    property string text: ""

    property string color: "black"
    property string backgroundColor: "transparent"
    property string borderColor: "black"
    property string selectedColor: "transparent"
    property string selectedBackgroundColor: "black"
    property string selectedBorderColor: "transparent"
    property int transitionTime: 300
    property int fontsize: 8
    property int borderwidth: 5
    property bool toggle: false
    signal click()
    signal hold()
    signal release()


    property bool isSelected: false
    property bool isHeld: false

    Rectangle {
        anchors.fill: root
        color: root.isSelected ? root.selectedBackgroundColor : root.backgroundColor
        border.color: root.isSelected ? root.selectedBorderColor : root.borderColor
        border.width: borderwidth
        Text {
            id: label
            color: root.isSelected ? root.selectedColor : root.color
            text: root.text
            anchors.centerIn: parent
            font.pointSize: fontsize
        }
    }
    MouseArea {
        anchors.fill: root
        hoverEnabled: true
        onClicked: {
            if(root.toggle){
                root.isSelected = !root.isSelected;
            }else{
                root.isSelected = true;
                timer.start();
            }
            console.log("click (" + this + ") " +  root.isSelected);
            root.click()
        }
        onPressAndHold: {
            root.isSelected = true;
            root.isHeld = true;
            console.log("hold " + this);
            root.hold()
        }
        onReleased: {
            if(root.isHeld){
                root.isSelected = false;
            }
            console.log("release (" + this + ")");
            root.release()
        }
    }
    Timer {
        id: timer
        interval: root.transitionTime
        repeat: false
        onTriggered: {
            root.isSelected = false;
            console.log("click clear (" + this + ") " +  root.isSelected);
        }
    }
}
