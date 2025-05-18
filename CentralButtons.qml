// CentralButtons.qml

import QtQuick 2.0
//import QtQuick.Controls 2.0
import SddmComponents 2.0





// central panel buttons
Item {
    id: centralbuttonsroot

    // size includes both buttons
    width: sessionbutton.width + layoutbutton.width
    // height is the same as sessionbutton height
    height: sessionbutton.height





// PUBLIC PROPERTIES AND PROPERTIES HOLDING A PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // this property holds an openSessionMenu() function from "Main.qml"
    property var openSessionMenu

    // this property holds an openLayoutMenu() function from "Main.qml"
    property var openLayoutMenu



    // property holding setFocus() function from "Main.qml"
    // this is not needed as setFocus() function from "Main.qml" is automatically inherited
    //property var setFocus



    // last button which had focus
    property string last_focussed_button: "session"



    // giveFocus: unfocus all of the available bottom buttons
    function giveFocus(button) {
        // do actions depending on button type
        switch (button) {
        // sessionbutton has to receive a focus
        case "session":
            // set the last_focussed_button to "session"
            last_focussed_button = button;
            // give sessionbutton the focus
            sessionbutton.focus = true;
            break;

        // layoutbutton has to receive a focus
        case "layout":
            // set the last_focussed_button button to "layout"
            last_focussed_button = button;
            // give layoutbutton the focus
            layoutbutton.focus = true;
            break;

        // last hovered buton receives a focus
        case "last":
            // is last_focussed_button the "layout"?
            if (last_focussed_button === "layout") {
                // give focus to layoutbutton
                layoutbutton.focus = true;
            } else {
                // give focus to sessionbutton
                sessionbutton.focus = true;
            }
            break;
        }
    }




// INNER PROPERTIES AND INNER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // SESSION BUTTON
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    // Session button white
    ButtonWhite {
        id: sessionbutton
        // width and height of a ButtonWhite from ButtonWhite.qml
        width: buttonwidth
        height: buttonheight

        // button type is "left"
        buttontype: "left"

        // button label is translated (session)
        buttonlabel: textConstants.session

        // place it by the left side of the layoutbutton
        anchors.right: layoutbutton.left

        // do actions when component is completed
        Component.onCompleted: {
            // assign an openSessionMenu from "Main.qml" to openMenu property in "ButtonWhite.qml"
            sessionbutton.openMenu = centralbuttonsroot.openSessionMenu;
        }

        // key navigations
        // on RIGHT key pressed go to layout/keyboard button
        KeyNavigation.right: layoutbutton
        // on LEFT key pressed go to layout/keyboard button
        KeyNavigation.left: layoutbutton
        // on TAB key pressed go to layout/keyboard button
        KeyNavigation.tab: layoutbutton

        // keyboard navigation and actions
        Keys.onPressed: {
            // when BACKTAB or ESCAPE key is pressed
            if (event.key === Qt.Key_Backtab || event.key === Qt.Key_Escape || event.key === Qt.Key_Up) {
                // remember the last focussed button
                last_focussed_button = "session";
                // go directly to login
                setFocus("login");
                // do not let the event to propagate down to parent
                event.accepted = true;

            // when RETURN/ENTER or SPACE key is pressed
            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                // provide the mouse click action; button is pressed
                // open the session menu
                sessionbutton.onClicked();
                // do not let the event to propagate down to parent
                event.accepted = true;

            // when DOWN key is pressed
            } else if (event.key === Qt.Key_Down) {
                // remember the last focussed button
                last_focussed_button = "session";
                // give focus to the nearest possible button from hibernate to the right
                setFocus("bottombuttons", "middle");
                // do not let the event to propagate down to parent
                event.accepted = true;
            }
        }
    }



    // LAYOUT BUTTON
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    // layout (keyboard) button white
    ButtonWhite {
        id: layoutbutton
        // width and height of a ButtonWhite from ButtonWhite.qml
        width: buttonwidth
        height: buttonheight

        // button type is "right"
        buttontype: "right"

        // button label is translated (layout)
        buttonlabel: textConstants.layout

        // place it by the right side of the sessionbutton
        anchors.left: sessionbutton.right

        // signal to open menu (keyboard / layout)
        //onOpenMenu: openKeyboardMenu();

        // do actions when component is completed
        Component.onCompleted: {
            // assign an openSessionMenu from "Main.qml" to openMenu property in "ButtonWhite.qml"
            layoutbutton.openMenu = centralbuttonsroot.openLayoutMenu;
        }



        // key navigations
        // on LEFT key pressed go to session button
        KeyNavigation.left: sessionbutton
        // on RIGHT key pressed go to layout/keyboard button
        KeyNavigation.right: sessionbutton
        // on BACKTAB key pressed go to session button
        KeyNavigation.backtab: sessionbutton

        // keyboard navigation and actions
        Keys.onPressed: {
            // when ESCAPE key is pressed
            if (event.key === Qt.Key_Escape || event.key === Qt.Key_Up) {
                // remember the last focussed button
                last_focussed_button = "layout";
                // go directly to login
                setFocus("login");
                // do not let the event to propagate down to parent
                event.accepted = true;

            // when RETURN/ENTER or SPACE key is pressed
            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                // provide the mouse click action; button is pressed
                // open the keyboard layout menu
                layoutbutton.onClicked();
                // do not let the event to propagate down to parent
                event.accepted = true;

            // when DOWN key is pressed
            } else if (event.key === Qt.Key_Down) {
                // remember the last focussed button
                last_focussed_button = "layout";
                // give focus to the nearest possible button from hibernate to the right
                setFocus("bottombuttons", "middle");
                // do not let the event to propagate down to parent
                event.accepted = true;

            // when TAB key is pressed
            } else if (event.key === Qt.Key_Tab) {
                // give focus to the nearest possible button from hibernate to the right
                setFocus("bottombuttons", "left");
                // do not let the event to propagate down to parent
                event.accepted = true;
            }
        } // Keys.onPressed END
    } // keyboard/layout button white END
} // central panel buttons END
