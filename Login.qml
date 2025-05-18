// Login.qml

import QtQuick 2.0
//import QtQuick.Controls 2.0
import SddmComponents 2.0




// LOGIN MAIN ITEM
Item {
    id: loginroot
    width: textboxwidth
    height: textboxheight





// LOGINROOT PROPERTIES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // set the text font family
    property string login_font_family: "Sans"

    // set the text font color (it is the centerpanel blue)
    readonly property color text_field_text_color: "#3097ff"

    // textbox width
    property int textboxwidth: textboxleft.width + textboxmiddle.width + textboxright.width
    // textbox height
    readonly property int textboxheight: 88



    // VARIABLES HOLDING A FUNCTION
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    // variable holds a function from Main.qml to set focus with keyboard
    property var setFocus



    // variable holds the "doLogin" function from Main.qml
    property var doLogin



    // variable holds the "openUserList()" function from MAin.qml
    property var openUserList





// LOGINROOT FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // getUsername: returns the current username
    function getUsername() {
        // return the content of the name text field
        return name.text;
    }

    // setUsername: sets the user name in the username textfield
    function setUsername(username) {
        // fills the username in the name textbox
        name.text = username;
    }

    // getPassword: return the current password
    function getPassword() {
        // return the content of the password text field
        return password.text;
    }



    // resetPassword: this will reset/blank password
    function resetPassword() {
        password.text = "";
    }





    // this will set the focus on username field
    function setLoginFocus() {
        if (name.visible === true) {
            name.focus = true;
        } else {
            password.focus = true;
        }
    }

    // actions after login.qml is assembled
    Component.onCompleted: {
        // give focus to user (name) textbox
        setLoginFocus();
    }

    // when focus has changed, set the focus to a username or password text field
    onFocusChanged: setLoginFocus();





// LOGINROOT CONTENT ///////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // TEXTBOX LABEL
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // label above the username/password text fields
    // it shows "Username" or "Password" text in language origin
    Text {
        id: textboxlabel
        // show the "Username" text
        text: textConstants.userName + ":"
        // set the text font
        font.family: login_font_family
        font.pixelSize: 22
        font.bold: true
        // set the text color
        color: "white"

        // place it on the top of loginroot, horizontally centered
        anchors.top: loginroot.top
        anchors.horizontalCenter: loginroot.horizontalCenter



        // these are the states of textboxlabel
        states: [
            // this state shows the "Username" label
            State {
                name: "shownamelabel"
                PropertyChanges {
                    target: textboxlabel
                    text: textConstants.userName + ":"
                }
            },
            // this state shows the "Password" label
            State {
                name: "showpasswordlabel"
                PropertyChanges {
                    target: textboxlabel
                    text: textConstants.password + ":"
                }
            }
        ]
    } // textboxlabel END





    // TEXTBOX
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // textbox images and textfields
    // textbox images (borders and inside)
    Item {
        id: textbox
        // textbox width and height are set by properties
        width: textboxwidth
        height: textboxheight
        // place it under the textboxlabel, horizontally centered
        anchors.top: textboxlabel.bottom
        anchors.horizontalCenter: textboxlabel.horizontalCenter



        // TEXTBOX IMAGES
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        // textbox left part
        Image {
            id: textboxleft
            // width is the png image width
            width: 40
            // height is set by loginroot property
            height: textboxheight
            source: "images/textbox_left.png"
            // place it by the left side of textboxmiddle
            anchors.right: textboxmiddle.left
        }
        // textbox middle part
        Image {
            id: textboxmiddle
            // width can be any size
            width: 400
            // height is set by loginroot property
            height: textboxheight
            source: "images/textbox_center.png"
            // place it in the center of the parent (textbox)
            anchors.centerIn: parent

        }
        // textbox right part
        Image {
            id: textboxright
            // width is the png image width
            width: 40
            // height is set by loginroot property
            height: textboxheight
            source: "images/textbox_right.png"
            // place it by the right side of textboxmiddle
            anchors.left: textboxmiddle.right
        }



        // TEXTBOX USERNAME ICON
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        // username icon
        Image {
            id: usernameicon
            // icon size (width and height)
            width: 28
            height: 28
            // Qt.UserRole + 4 is SDDM.IconRole (from src/greeter/UserModel.h)
            //source: userModel.data(userModel.index(userModel.lastIndex, 0), Qt.UserRole + 4);
            // the icon source
            source: "images/username_icon.png"
            // place it by the name left side, vertically centered
            anchors.right: name.left
            anchors.verticalCenter: name.verticalCenter
            // set the default visibility (it will be changed)
            visible: true

            // mouse interactions
            MouseArea {
                // set the mouse interaction on the whole parent area
                anchors.fill: parent

                // mouse has clicked
                onClicked: {
                    // isn't the username textfield empty?
                    //if (name.text !== "") {
                        // hide password field and show username text field
                        //name.state = "hidename";
                        //password.state = "showpassword";
                        //textboxlabel.state = "showpasswordlabel";

                        // open userlist menu
                        openUserList();

                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    //}
                }
            }
        }



        // USERNAME TEXT FIELD
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////




        // user name text field
        TextBox {
            id: name
            // size of the textbox
            width: 350
            height: 34

            //font.styleName: ""
            font.family: login_font_family
            font.bold: true
            font.pixelSize: 20
            // text color is similar to centerpanel blue
            textColor: text_field_text_color

            //** last logged user name shows as default
            text: userModel.lastUser

            // making white borders on white background
            borderColor: "#ffffff"
            hoverColor: "#ffffff"
            focusColor: "#ffffff"

            // visible by default when sddm starts
            visible: true

            // place it in the center of parent (textbox)
            anchors.centerIn: parent

            //KeyNavigation.backtab: PasswordBox; KeyNavigation.tab: PasswordBox



            // states for hiding or showing username text fields
            states: [
                // hide username text field
                State {
                    name: "hidename"
                    // hide username text field
                    PropertyChanges {
                        target: name
                        visible: false
                        //focus: false
                    }
                    // hide username icon
                    PropertyChanges {
                        target: usernameicon
                        visible: false
                    }
                },
                // show username text field
                State {
                    name: "showname"
                    // show username text field
                    PropertyChanges {
                        target: name
                        visible: true
                        focus: true
                    }
                    // show username icon
                    PropertyChanges {
                        target: usernameicon
                        visible: true
                    }
                }
            ]



            // username keyboard actions
            // when RETURN/ENTER key is pressed and username text field is filled,
            // then hide username text field and show password field
            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    // set login animation of the right arrow
                    // 1 = hide usarname and show password
                    clickanim.loops = 1;
                    // start login animation of the right arrow
                    clickanim.start();
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when TAB key is pressed
                } else if (event.key === Qt.Key_Tab) {
                    // go to session button in Main.qml
                    // look at the property "setFocus" declared above
                    setFocus("centralbuttons", "session");
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when DOWN key is pressed
                } else if (event.key === Qt.Key_Down) {
                    // go to session button in Main.qml
                    // look at the property "setFocus" declared above
                    setFocus("centralbuttons", "last");
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when BACKTAB key is pressed
                } else if (event.key === Qt.Key_Backtab) {
                    // go to bottom buttons in Main.qml
                    // look at the property "setFocus" declared above
                    setFocus("bottombuttons", "right");
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when ESCAPE key is pressed
                } else if (event.key === Qt.Key_Escape) {
                    // isn't the textfield empty?
                    if (name.text != "") {
                        // empty the user (name) field
                        name.text = "";
                    } else {
                        // username text field is empty
                        // open userlist menu
                        openUserList();
                    }

                    // do not let the event to propagate down to parent
                    event.accepted = true;
                }
            }
        } // name END



        // PASSWORD ICON
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        // password icon
        Image {
            id: passwordicon
            // icon size
            width: 28
            height: 28
            source: "images/password_icon.png"

            // place it by the left side of the password text field, vertically centered
            anchors.right: password.left
            anchors.verticalCenter: password.verticalCenter

            // set it as invisible by default, when sddm starts (it will change by states)
            visible: false

            // mouse interactions
            MouseArea {
                // set the mouse interaction on the whole parent area
                anchors.fill: parent

                // mouse has clicked
                onClicked: {
                    // hide password field and show username text field
                    password.state = "hidepassword";
                    name.state = "showname";
                    textboxlabel.state = "shownamelabel";
                    // do not let the event to propagate down to parent
                    event.accepted = true;
                }
            }
        }



        // PASSWORD TEXT FIELD
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        // password text field
        PasswordBox {
            id: password
            // text field size
            width: 350
            height: 34

            // warning icon image
            imageFadeOut: 0
            imageFadeIn: 0
            image: "images/warning.png"

            // set the password font (though it shows only circles)
            font.family: login_font_family
            font.bold: true
            font.pixelSize: 20

            // text color is set by the loginroot property
            textColor: text_field_text_color

            // tooltip colors
            tooltipFG: "#ffffff"
            tooltipBG: "#ffc44d"

            // making white borders on white background
            borderColor: "#ffffff"
            hoverColor: "#ffffff"
            focusColor: "#ffffff"

            // invisible by default when sddm starts (it will change by states)
            visible: false

            // place it in the center of parent (textbox)
            anchors.centerIn: parent

            // show only circles instead of letters (it's a password)
            echoMode: TextInput.Password



            // states for hiding showing password field
            states: [
                // hide password text field
                State {
                    name: "hidepassword"
                    // hide password text field
                    PropertyChanges {
                        target: password
                        visible: false
                        //focus: false
                    }
                    // hide password icon
                    PropertyChanges {
                        target: passwordicon
                        visible: false
                    }
                },
                // show password text field
                State {
                    name: "showpassword"
                    // show password text field
                    PropertyChanges {
                        target: password
                        visible: true
                        focus: true
                    }
                    // show password icon
                    PropertyChanges {
                        target: passwordicon
                        visible: true
                    }
                }
            ]

            //KeyNavigation.backtab: "name"; KeyNavigation.tab: "name"

            // keyboard actions like swith the name/password field and login
            Keys.onPressed: {
                // when a TAB key is pressed
                if (event.key === Qt.Key_Tab) {
                    // go to session button in Main.qml
                    // look at the property "setFocus" declared above
                    setFocus("centralbuttons", "session");
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when DOWN key is pressed
                } else if (event.key === Qt.Key_Down) {
                    // go to session button in Main.qml
                    // look at the property "setFocus" declared above
                    setFocus("centralbuttons", "last");
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when BACKTAB key is pressed
                } else if (event.key === Qt.Key_Backtab) {
                    // go to bottom buttons in Main.qml
                    // look at the property "setFocus" declared above
                    setFocus("bottombuttons", "right");
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when RETURN/ENTER key is pressed,
                // then execute the login to system
                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    // set login animation of the right arrow
                    // 3 = doLogin() after click animation stops
                    clickanim.loops = 3;
                    // start login animation of the right arrow
                    clickanim.start();
                    // start login process
                    doLogin("login");
                    // do not let the event to propagate down to parent
                    event.accepted = true;

                // when ESCAPE key is pressed
                // clear the password or hide password field and show username text field
                } else if (event.key === Qt.Key_Escape) {
                    // is the password not empty?
                    if (password.text !== "") {
                        // clear the password
                        password.text = "";
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    } else {
                        // hide password field and show username text field
                        password.state = "hidepassword";
                        name.state = "showname";
                        textboxlabel.state = "shownamelabel";
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    }
                }
            } // Keys.onPressed END
        } // password END



        // RIGHT ARROW
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        // right arrow
        Image {
            id: arrow
            // icon size
            width: 28
            height: 28
            source: "images/arrow_right.png"

            // place it by the right side of the name, vertically centered
            anchors.left: name.right
            anchors.verticalCenter: name.verticalCenter

            // visibility will not change (it is visible with both username and password text fields)
            //visible: true

            // mouse interactions
            MouseArea {
                // set the mouse interaction on the whole parent area
                anchors.fill: parent

                // mouse has clicked
                onClicked: {
                    // the username field is active/visible
                    if (name.visible) {
                        // set the clickanim loops (1 = switch to the password text field)
                        clickanim.loops = 1;
                        // start the click animation and then switch to password text field
                        clickanim.start();
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    // the password field is active/visible
                    } else if (password.visible) {
                        // set the clickanim loops (3 = start the login procedure)
                        clickanim.loops = 3;
                        // start the click animation and then process login procedure
                        clickanim.start();
                        // do not let the event to propagate down to parent
                        event.accepted = true;
                    }
                }
            } // MouseArea END

            // mouse click animation
            SequentialAnimation {
                id: clickanim
                loops: 3
                // opacity to transparent
                PropertyAnimation {
                    target: arrow
                    property: "opacity"
                    to: 0.00
                    duration: 45
                }
                // opacity to visible
                PropertyAnimation {
                    target: arrow
                    property: "opacity"
                    to: 1.00
                    duration: 45
                }

                // the animation starts
                onStarted: {
                    // clear the messages text in Main.qml
                    doLogin("prelogin");
                }

                // the animation is finished
                onStopped: {
                    // loops 3x = start login process
                    if (clickanim.loops === 3) {
                        // start login process
                        doLogin("login");
                    // loops not 3x = go to password entry
                    } else {
                        if (name.text !== "") {
                            name.state = "hidename";
                            password.state = "showpassword";
                            textboxlabel.state = "showpasswordlabel";
                        }
                    }
                }
            }
        } // arrow END

    } // textbox END





    // CAPS LOCK WARNING
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // caps lock warning
    Text {
        id: capslockwarning
        // warning text translated in origin language
        text: textConstants.capslockWarning
        // capslock text color
        color: "#ffc44d"

        // set the warning text font
        font.family: login_font_family
        font.bold: true
        font.pixelSize: 20

        // place it on the textbox bottom, horizontally centered
        anchors.top: textbox.bottom
        anchors.horizontalCenter: textbox.horizontalCenter

        // visible only when caps lock is turned on
        visible: keyboard.capsLock
    }

} // loginroot END
