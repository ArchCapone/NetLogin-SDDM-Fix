// BottomButtons.qml

import QtQuick 2.0
//import QtQuick.Controls 2.0
import SddmComponents 2.0





// bottom buttons
Item {
    id: bottombuttonsroot

    //width: // the sum of dynamically created bottom buttons "ButtonGreen.qml"
    // height is same as height of button images (don't change this)
    height: 70





// PUBIC FUNCTIONS AND PROPERTIES HOLDING PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // giveFocus: unfocus all of the available bottom buttons and set and give focus to the hovered_bottom_button
    function giveFocus(button, index) {
        // is there at least one bottom button?
        if (buttons_count > 0) {
            switch (button) {
            case "left":
                // set hovered bottom button to the left most button
                hovered_bottom_button = 0;
                break;
            case "right":
                // set hovered bottom button to the right most button
                hovered_bottom_button = buttons_count - 1;
                break;
            case "index":
                // set hovered bottom button to the button with index
                hovered_bottom_button = index;
                // cycle through all available bottom buttons
                for (var i = 0; i < buttons_count; i++) {
                    // set the cycled bottom button focus to false
                    bottombuttons.children[i].focus = false;
                }
                break;
            }

            // give focus to the new hovered_bottom_button
            bottombuttons.children[hovered_bottom_button].focus = true;

        } else {
            // there are no bottom buttons
            switch (button) {
            case "left":
                // trying to reach leftmost bottom button will jump to login
                // go to the login from "layout" button
                setFocus("login");
                break;
            case "right":
                // trying to reach rightmost bottom button will jump to "layout" button
                // go to the "layout" button from the login
                setFocus("centralbuttons", "layout");
                break;
            case "middle":
                // trying to reach middle bottom button will jump back to central buttons
                // go back to the last central button
                setFocus("centralbuttons", "last");
                break;
            }
        }
    }



    // giveFocus: unfocus all of the available bottom buttons and give focus to hovered_bottom_button
    /*function giveFocus(index) {
        // is there at least one bottom button?
        if (buttons_count > 0) {
            // cycle through all available bottom buttons
            for (var i = 0; i < buttons_count; i++) {
                // set the cycled bottom button focus to false
                bottombuttons.children[i].focus = false;
            }
            // setting the hovered_bottom_button
            hovered_bottom_button = index
            // give focus to the new hovered_bottom_button
            bottombuttons.children[hovered_bottom_button].focus = true;
        }
    }*/

    // property holding setFocus() function from "Main.qml"
    // this is not needed as setFocus() function from "Main.qml" is automatically inherited
    //property var setFocus





// INNER PROPERTIES AND INNER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // handles the availability of bottom buttons
    property var can_hibernate: ["Suspend", config.TranslateSuspend || textConstants.suspend, sddm.canSuspend]
    property var can_suspend: ["Hibernate", config.TranslateHibernate || textConstants.hibernate, sddm.canHibernate]
    property var can_reboot: ["Reboot", config.TranslateReboot || textConstants.reboot, sddm.canReboot]
    property var can_poweroff: ["Shutdown", config.TranslateShutdown || textConstants.shutdown, sddm.canPowerOff]



    // count of bottom buttons
    property int buttons_count: 0
    // the hovered bottom button used for keyboard navigations
    property int hovered_bottom_button: 0



    // creates the bottom buttons
    function loadBottomButtons() {
        var btn;
        // assembling a component of a "ButtonGreen.qml"
        var component = Qt.createComponent("ButtonGreen.qml");

        // is the component ready to create (is assembled)?
        if (component.status == Component.Ready) {
            // create all buttons if they are available
            if (can_hibernate) {
                // creates an instance of button component
                // and place it in "bottombuttons"
                btn = component.createObject(bottombuttons);
                // set the button type (for visual look)
                // possible values are: "left" or "right"
                btn.buttontype = "left";
                // set button label
                btn.buttonlabel = i18nd("plasma_lookandfeel_org.kde.lookandfeel","Hibernate"); //textConstants.hibernate
                // set the function for button action on mouse click
                btn.onclickFunction = sddm.hibernate;
                // set the button index
                btn.index = buttons_count
                // assign the function giveFocus() to the giveFocus property from ButtonGreen.qml
                btn.giveFocus = bottombuttonsroot.giveFocus;
                // initialize the buttton
                btn.init();
                // increment button counter
                buttons_count++;
            }
            if (can_suspend) {
                // creates an instance of button component
                // and place it in "bottombuttons"
                btn = component.createObject(bottombuttons);
                // set the button type (for visual look)
                // possible values are: "left" or "right"
                btn.buttontype = "left";
                // set button label
                btn.buttonlabel = i18nd("plasma_lookandfeel_org.kde.lookandfeel","Suspend"); //textConstants.suspend
                // set the function for button action on mouse click
                btn.onclickFunction = sddm.suspend;
                // set the button index
                btn.index = buttons_count
                // assign the function giveFocus() to the giveFocus property from ButtonGreen.qml
                btn.giveFocus = bottombuttonsroot.giveFocus;
                // initialize the buttton
                btn.init();
                // increment button counter
                buttons_count++;
            }
            if (can_reboot) {
                // creates an instance of button component
                // and place it in "bottombuttons"
                btn = component.createObject(bottombuttons);
                // set the button type (for visual look)
                // possible values are: "left" or "right"
                btn.buttontype = "right";
                // set button label
                btn.buttonlabel = textConstants.reboot;
                // set the function for button action on mouse click
                btn.onclickFunction = sddm.reboot;
                // set the button index
                btn.index = buttons_count
                // assign the function giveFocus() to the giveFocus property from ButtonGreen.qml
                btn.giveFocus = bottombuttonsroot.giveFocus;
                // initialize the buttton
                btn.init();
                // increment button counter
                buttons_count++;
            }
            if (can_poweroff) {
                // creates an instance of button component
                // and place it in "bottombuttons"
                btn = component.createObject(bottombuttons);
                // set the button type (for visual look)
                // possible values are: "left" or "right"
                btn.buttontype = "right";
                // set button label
                btn.buttonlabel = textConstants.shutdown;
                // set the function for button action on mouse click
                btn.onclickFunction = sddm.powerOff;
                // set the button index
                btn.index = buttons_count
                // assign the function giveFocus() to the giveFocus property from ButtonGreen.qml
                btn.giveFocus = bottombuttonsroot.giveFocus;
                // initialize the buttton
                btn.init();
                // increment button counter
                buttons_count++;
            }
        }
    }





    // do something when main component has completed
    Component.onCompleted: {
        // loading all available bottom buttons
        loadBottomButtons();
    }





// KEYBOARD ACTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // keyboard actions
    Keys.onPressed: {
        // are there any bottom buttons?
        if (buttons_count > 0) {
            // when ESCAPE key is pressed
            if (event.key === Qt.Key_Escape) {
                // go directly to login
                setFocus("login");
                // do not let the event to propagate down to parent
                event.accepted = true;

            // when UP key is pressed
            } else if (event.key === Qt.Key_Up) {
                // give focus to the last known central button
                setFocus("centralbuttons", "last");
                // do not let the event to propagate down to parent
                event.accepted = true;

            // when RIGHT or TAB key is pressed
            } else if (event.key === Qt.Key_Right || event.key === Qt.Key_Tab) {
                // is there a next button to the right of the current button?
                if (buttons_count > 1 && hovered_bottom_button < buttons_count - 1) {
                    // give focus to the next button to the right (increment hovered_bottom_button by 1)
                    giveFocus(++hovered_bottom_button);
                    // do not let the event to propagate down to parent
                    event.accepted = true;
                } else {
                    // was the TAB key pressed?
                    if (event.key === Qt.Key_Tab) {
                        // give focus to the login
                        setFocus("login");
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    // the RIGHT key was pressed
                    } else {
                        // set hovered bottom button to the left most button
                        hovered_bottom_button = 0;
                        // give focus to the next button to the right
                        giveFocus(hovered_bottom_button);
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    }
                }


            // when LEFT or BACKTAB key is pressed
            } else if (event.key === Qt.Key_Left || event.key === Qt.Key_Backtab) {
                // is there a previous button to the left of the current button?
                if (buttons_count > 1 && hovered_bottom_button > 0) {
                    // give focus to the previous button to the left (decrement hovered_bottom_button by 1)
                    giveFocus(--hovered_bottom_button);
                    // do not let the event to propagate down to parent
                    event.accepted = true;
                } else {
                    // the BACKTAB key was pressed
                    if (event.key === Qt.Key_Backtab) {
                        // give focus to the centralbuttons layout
                        setFocus("centralbuttons", "layout");
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    // the LEFT key was pressed
                    } else {
                        // set hovered bottom button to the right most button
                        hovered_bottom_button = buttons_count - 1;
                        // give focus to the next/previous button to the right/left
                        giveFocus(hovered_bottom_button);
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    }
                }

            // when RETURN/ENTER or SPACE key is pressed
            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                // provide the mouse click action; button is pressed
                bottombuttons.children[hovered_bottom_button].onClick();
                // do not let the event to propagate down to parent
                event.accepted = true;
            }
        }
    } // Keys.onPress END





// BOTTOM BUTTONS CONTAINER
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // bottom buttons container
    // it will be filled dynamically with bottom buttons
    Row {
        id: bottombuttons

        // place it in the center of a parent (bottombuttonsroot)
        anchors.centerIn: parent
    }

} // bottombuttonsroot END
