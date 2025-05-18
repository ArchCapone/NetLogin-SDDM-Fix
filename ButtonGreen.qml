// ButtonGreen.qml

import QtQuick 2.0
//import QtQuick.Controls 2.0
//import SddmComponents 2.0

// BUTTON LEFT MAIN ITEM
Item {
    id: buttonroot
    width: buttonwidth
    height: buttonheight





// PUBLIC PROPERTIES AND PROPERTIES HOLDING PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // index for object identification
    property int index

    // button label
    property string buttonlabel: ""

    // the type of a button ("left" or "right")
    property string buttontype



    // property holding a function on mouse click
    property var onclickFunction


    // variable holds the giveFocus() function from BottomButtons.qml
    property var giveFocus



    // initialize button after it is completed
    // after "Component.onCompleted"
    function init() {
        // switch depends on the type of button "left" or "right"
        switch (buttontype) {
        // the left button type
        case "left" :
            leftpartimg = "images/button_left_green.png";
            rightpartimg = "images/button_right_green.png";
            break;
        // the right button type
        case "right" :
            leftpartimg = "images/button_left_green_mirror.png";
            rightpartimg = "images/button_right_green_mirror.png";
            break;
        }
    }



    // run this function when mouse clicks or key ENTER/RETURN/SPACE presses
    function onClick() {
        // play click anim and process the appropriate action
        // look at "click_anim" below
        clickanim.start();
    }





// INNER PROPERTIES AND INNER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // whole button width
    property int buttonwidth: buttonleft.width + buttonmiddle.width + buttonright.width
    // button height (can't be changed)
    readonly property int buttonheight: 70

    // opacity of a buton bg images
    property real bgopacity: bgnormal

    // button bg states (opacity)
    readonly property real bgnormal: 0.00
    readonly property real bghover: 1.00
    readonly property real bgoff: 0.00



    // url of the left button part
    property url leftpartimg
    // url of the right button part
    property url rightpartimg





    // do animations on focus change
    onFocusChanged: {
        // button has focus; play ENTER
        if (buttonroot.focus) {
            // stop the exited animation
            exitanim.stop();
            // play on entered animation
            enteranim.start();

        // button has no focus; play EXIT
        } else if (!buttonroot.focus) {
            // stop the entered animation
            enteranim.stop();
            // play on exited animation
            exitanim.start();
        }
    }



    // run this function when mouse pointer enters the button
    function onEnter() {
        // stop the exited animation
        exitanim.stop();
        // play on entered animation
        enteranim.start();
    }

    // run this function when mouse pointer exits the button
    function onExit() {
        // stop the entered animation
        enteranim.stop();
        // play on exited animation
        exitanim.start();
    }





// ANIMATIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    // animation on mouse entered
    // button bg and label text parallel animation
    SequentialAnimation {
        id: enteranim
        // button bg opacity goes highlighted
        PropertyAnimation {
            target: buttonroot
            property: "bgopacity"
            to: bghover
            duration: 150
        }
    }



    // animation on mouse exited
    // button bg and label text parallel animation
    SequentialAnimation {
        id: exitanim
        PropertyAnimation {
            target: buttonroot
            property: "bgopacity"
            to: bgnormal
            duration: 200
        }
    }



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
            bgopacity = bghover; // bgnormal;

            // do the appropriate action after button press
            // look at the "onclickFunction" property (above)
            onclickFunction(); //
        }
    }





// BUTTON IMAGES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // button green
    Item {
        id: buttonbg
        width: buttonwidth
        height: buttonheight
        // this will change with mouse action
        opacity: bgopacity

        // button left image part
        Image {
            id: buttonleft
            width: 40
            height: buttonheight
            source: leftpartimg
            anchors.right: buttonmiddle.left
        }
        // button middle image part
        Image {
            id: buttonmiddle
            // width is same as the label width
            width: label.width
            height: buttonheight
            source: "images/button_center_green.png"
            anchors.centerIn: parent
        }
        // button right image part
        Image {
            id: buttonright
            width: 40
            height: buttonheight
            source: rightpartimg
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
        font.family: "Sans"
        font.pixelSize: 20
        font.bold: true
        color: "white"
        anchors.centerIn: buttonroot
    }





// MOUSE INTERACTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // mouse interaction
    MouseArea {
        // active on a whole button area
        anchors.fill: parent

        // enable the hover function to perform
        // without a mouse button pressed
        hoverEnabled: true

        // entering button with a mouse pointer
        onEntered: {
            onEnter();
        }


        // exiting button with a mouse pointer
        onExited: {
            onExit();
        }


        // clicked on the button
        onClicked: {
            // give focus to clicked button
            giveFocus("index", index);
            // start clickanim animation and following actions
            clickanim.start();
        }

    } // MouseArea END

} // buttonroot END
