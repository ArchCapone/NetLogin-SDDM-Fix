// ButtonWhite.qml

import QtQuick 2.0
//import QtQuick.Controls 2.0
//import SddmComponents 2.0

// BUTTON LEFT MAIN ITEM
Item {
    id: buttonroot
    width: buttonwidth
    height: buttonheight





// PUBLIC PROPERTIES AND PROPERTIES HOLDING FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // whole width of a button
    property int buttonwidth: buttonleft.width + buttonmiddle.width + buttonright.width
    // button height (can't be changed)
    readonly property int buttonheight: 70

    // the type of a button ("left" or "right")
    property string buttontype: "left"

    // button label
    property string buttonlabel: ""



    // property holding an appropriate function to invoke when button is pressed (clicked on)
    property var openMenu



    // run this function when mouse clicks or key ENTER/RETURN/SPACE presses
    function onClicked() {
        // play click anim and process the appropriate action
        // look at "click_anim" below
        clickanim.start();
    }





// INNER PROPERTIES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // opacity of a buton bg images
    property real bgopacity: bgnormal

    // button bg states (opacity)
    readonly property real bgnormal: 0.40
    readonly property real bghover: 1.00
    readonly property real bgoff: 0.00



    // button label color
    property color labelcolor: labelnormal

    // button lable states (color)
    readonly property color labelnormal: "#ffffff"
    readonly property color labelhover: "#3d9dff"
    //not used: readonly property color labeloff: "#3d9dff"


    // url of the left button part
    property url leftpartimg
    // url of the right button part
    property url rightpartimg





// onCompleted and focus
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    // when this button is assembled completely
    Component.onCompleted: {
        // switch by a button type (left or right)
        switch (buttontype) {
        // assign images' URLs of the left button type
        case "left" :
            leftpartimg = "images/button_left_white.png";
            rightpartimg = "images/button_right_white.png";
            break;
        // assign images' URLs of the right button type
        case "right" :
            leftpartimg = "images/button_left_white_mirror.png";
            rightpartimg = "images/button_right_white_mirror.png";
            break;
        }
    }



    // do animations on focus change
    onFocusChanged: {
        // button has focus
        if (buttonroot.focus) {
            // stop on extited animation
            exitanim.stop();
            // play on entered animation
            enteranim.start();

        // button has no focus
        } else if (!buttonroot.focus) {
            // stop on entered animation
            enteranim.stop();
            // play on exited animation
            exitanim.start();
        }
    }





// ANIMATIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // animation on mouse click
    SequentialAnimation {
        id: clickanim
        // do the animation 3 times
        loops: 3
        // button bg goes off
        PropertyAnimation {
            target: buttonroot
            property: "bgopacity"
            to: bgoff
            duration: 45
        }
        // button bg goes highlighted
        PropertyAnimation {
            target: buttonroot
            property: "bgopacity"
            to: bghover
            duration: 45
        }

        // the animation is finished
        onStopped: {
            // button bg goes normal state
            bgopacity = bgnormal;
            // label text color goes normal state
            labelcolor = labelnormal;

            // open the appropriate menu and hide the central panel
            openMenu();
        }
    }





// BACKGROUND IMAGES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    // button background
    Item {
        // width and height is set by the buttonroot properties
        width: buttonwidth
        height: buttonheight

        // this will change with mouse action
        opacity: bgopacity

        // button left image part
        Image {
            id: buttonleft
            // the width of the png image
            width: 40
            // button height is set by the buttonroot property
            height: buttonheight
            // png image is set by the property according to button type
            source: leftpartimg

            // place it by the left side of the buttonmiddle
            anchors.right: buttonmiddle.left
        }
        // button middle image part
        Image {
            id: buttonmiddle
            // width is same as the label width
            width: label.width
            // button height is set by the buttonroot property
            height: buttonheight
            // png image is same for "left" and "right" button types
            source: "images/button_center_white.png"

            // place it in the center of parent (Item with no id)
            anchors.centerIn: parent

        }
        // button right image part
        Image {
            id: buttonright
            // the width of the png image
            width: 40
            // button height is set by the buttonroot property
            height: buttonheight
            // png image is set by the property according to button type
            source: rightpartimg

            // place it by the right side of the buttonmiddle
            anchors.left: buttonmiddle.right
        }
    }





// BUTTON LABEL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // button label
    Text {
        id: label
        // text is set by instance of a button origin
        text: buttonlabel
        // font family is set by the buttonroot property
        font.family: "Sans"
        font.pixelSize: 20
        font.bold: true
        // this will change on mouse action
        color: labelcolor

        // place the label to the center of buttonroot
        anchors.centerIn: buttonroot
    }





// MOUSE INTERACTION
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    // mouse interaction
    MouseArea {
        // active on a whole button area
        anchors.fill: parent

        // enable the hover function to perform
        // without a mouse button pressed
        hoverEnabled: true

        // entering button with a mouse pointer
        onEntered:
            // button bg and label text parallel animation
            ParallelAnimation {
                id: enteranim
                // button bg opacity goes highlighted
                PropertyAnimation {
                    target: buttonroot
                    property: "bgopacity"
                    to: bghover
                    duration: 100
                }
                // label text color changes
                PropertyAnimation {
                    target: buttonroot
                    property: "labelcolor"
                    to: labelhover
                    duration: 100
                }
        }

        // exiting button with a mouse pointer
        onExited:
            // button bg and label text parallel animation
            ParallelAnimation {
                id: exitanim
                // button bg opacity goes normal
                PropertyAnimation {
                    target: buttonroot
                    property: "bgopacity"
                    to: bgnormal
                    duration: 100
                }
                // label text color changes
                PropertyAnimation {
                    target: buttonroot
                    property: "labelcolor"
                    to: labelnormal
                    duration: 100
                }
        }

        // clicked on the button
        onClicked:
            // start clickanim animation and other actions
            clickanim.start();

    } // MouseArea END

} // buttonroot END
