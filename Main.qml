// Main.qml (Updated without KDE dependencies)

import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtGraphicalEffects 2.15
import SddmComponents 2.0

// Comment out or remove KDE Plasma dependencies
//import org.kde.plasma.core 2.0 as PlasmaCore
//import org.kde.plasma.components 2.0 as PlasmaComponents
//import org.kde.plasma.extras 2.0 as PlasmaExtras


// MAIN RECTANGLE
Rectangle {
    id: mainroot
    width: 1024 //1920
    height: 768 //1080





    // MAIN FUNCTIONS
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // doLogin: handles the login and prelogin actions
    function doLogin(type) {
        // switch on type of action
        switch (type) {
            // pre-login actions
            case "prelogin":
                // clear the messages text
                messages.text = "";
                break;
                // login actions
            case "login":
                // login procedure (get info from login component)
                sddm.login(login.getUsername(), login.getPassword(), sessionmenu.getItemIndex());
        }
    }



    // open session menu
    function openSessionsMenu() {
        centralpanel.visible = false;
        sessionmenu.visible = true;

        // initialize the session menu
        sessionmenu.init();
        // give focus to the session menu
        sessionmenu.focus = true;
    }



    // open layout (keyboard) menu
    function openLayoutMenu() {
        centralpanel.visible = false;
        layoutmenu.visible = true;

        // initialize the layout menu
        layoutmenu.init();
        // give focus to the layout menu
        layoutmenu.focus = true;
    }



    // open layout (keyboard) menu
    function openUserList() {
        centralpanel.visible = false;
        userlist.visible = true;

        // initialize the layout menu
        userlist.init();
        // give focus to the layout menu
        userlist.focus = true;
    }



    // function which closes open menu and shows central panel
    function closeMenu() {
        // was the choice made from layoutmenu?
        // is layoutmenu visible?
        if (sessionmenu.visible) {
            // close session menu
            sessionmenu.visible = false;
            // was the choice made from sessionmenu?
            // is sessionmenu visible?
        } else if (layoutmenu.visible) {
            // set the keyboard layout to the chosen one
            keyboard.currentLayout = layoutmenu.getItemIndex();
            layoutmenu.visible = false;
            // was the choice made from userlist?
            // is userlist visible?
        } else if (userlist.visible) {
            // setting selected user to the login username text field
            // Qt.UserRole + 1 is SDDM.NameRole (from src/greeter/UserModel.h)
            login.setUsername( userModel.data(userModel.index(userlist.getItemIndex(), 0), Qt.UserRole + 1) );
            // close userlist menu
            userlist.visible = false;
        }

        // make central panel visible
        centralpanel.visible = true;
        // give the focus to login
        login.focus = true;
    }



    // set the focus of objects depending on keyboard actions
    // "object" is the object to which has to be given the focus
    // "hoverbutton" is the bottom button to which it's given focus
    // "hoverbutton" can be "left", "right", "middle" or "index"
    function setFocus(object, hoverbutton, index) {
        switch (object) {
            // go to login
            case "login" :
                login.focus = true;
                break;
                // give focus to session button
            case "centralbuttons" :
                // set the last focussed button and give it a focus
                centralbuttons.giveFocus(hoverbutton);
                break;
                // give focus to bottom buttons
            case "bottombuttons" :
                // give focus to the appropriate hoverbutton
                bottombuttons.giveFocus(hoverbutton);
                break;
        }
    }





    // SOME STAFF TO LOGIN ETC.
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // ?
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        // Updated to use modern function-based signal handler syntax
        function onLoginSucceeded() {
            // set the message to login succeeded sentence
            messages.text = textConstants.loginSucceeded;
        }

        function onLoginFailed() {
            // show message "login failed"
            messages.text = textConstants.loginFailed;
            // clear (reset) the password field
            login.resetPassword();
        }
    }

    // do actions when main component has completed
    Component.onCompleted: {
        // giving a focus to login
        login.setLoginFocus();
    }





    // BACKGROUND IMAGE
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // background image
    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop //or use: Stretch
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }

        // mouse interactions
        MouseArea {
            // applicable in whole Background area
            anchors.fill: parent

            // mouse has clicked on the mous earea
            onClicked: {
                // close menu and show centralpanel
                closeMenu();
            }
        }
    }




    // HOSTNAME with DATE and TIME
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // date and time
    Datetime {
        // place it on the top of th screen, centered and with specified margin
        anchors.top: mainroot.top
        anchors.topMargin: 30
        anchors.horizontalCenter: mainroot.horizontalCenter
    }





    // CENTRAL PANEL
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // central pannel
    Item {
        id: centralpanel
        // width and height are the same as cpimage (central_panel.png)
        width: cpimage.width
        height: cpimage.height
        // place it the center of screen
        anchors.centerIn: parent

        // central panel background image
        Image {
            id: cpimage
            // image width and height
            width: 822
            height: 504
            // image source
            source: "images/central_panel.png"
            // place it in the center of centralpanel
            anchors.centerIn: parent
        }

        // login text fields (username and password)
        Login {
            id: login
            // place it in the centralpanel top with margin
            anchors.top: parent.top
            anchors.topMargin: 150
            // place it in the horizontal center of centralpanel
            anchors.horizontalCenter: parent.horizontalCenter

            // do actions when Login component is completed
            Component.onCompleted: {
                // assigning the doLogin() function from "Main.qml" to the doLogin property from "Login.qml"
                login.doLogin = mainroot.doLogin;
                // assigning the openUserList() function from "Main.qml" to the openUserList property from "Login.qml"
                login.openUserList = mainroot.openUserList;
                // assigning the setFocus() function from "Main.qml" to the setFocus property from "Login.qml"
                login.setFocus = mainroot.setFocus;
            }
        }

        // central buttons (session and keyboard layout)
        CentralButtons {
            id: centralbuttons

            // place it on the centralpanel bottom with certain margin, horizontally centered
            anchors.bottom: centralpanel.bottom
            anchors.bottomMargin: 150
            anchors.horizontalCenter: centralpanel.horizontalCenter

            // assign open menu functions to appropriate properties
            Component.onCompleted: {
                // assigning openSessionsMenu() function from "Main.qml" to the openSessionMenu property from "Centralbuttons.qml"
                centralbuttons.openSessionMenu = mainroot.openSessionsMenu;
                // assigning openLayoutMenu() function from "Main.qml" to the openLayoutMenu property from "Centralbuttons.qml"
                centralbuttons.openLayoutMenu = mainroot.openLayoutMenu;
                // assigning the setFocus() function from "Main.qml" to the setFocus property from "Centralbuttons.qml"
                centralbuttons.setFocus = mainroot.setFocus;
            }
        } // central buttons END

    } // centralpanel END





    // MESSAGES
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // various messages as login faild etc.
    Text {
        id: messages
        // set the font and color
        font.family: "Sans"
        font.pixelSize: 22
        color: "greenyellow"

        // it is blank by default (when sddm starts)
        text: ""

        // place it on the bottom of the centralpanel, with certain margin, horizontally centered
        anchors.top: centralpanel.bottom
        anchors.topMargin: -80
        anchors.horizontalCenter: centralpanel.horizontalCenter

        // text horizontal alignment inside the Text component
        horizontalAlignment: Text.AlignHCenter
    }





    // MENUS
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // SessionMenu to choose a session
    MenuList {
        id: sessionmenu
        // true = menu is visible; false = menu is invisible
        visible: false
        // place the menu in the center of parent (mainroot)
        anchors.centerIn: parent

        // assign the number of menu items to the menu property
        items_count: sessionModel.rowCount()
        // set the default session index to last selected session
        item_index: sessionModel.lastIndex

        // type of a menu
        menu_type: "session"

        // do actions when component is completed
        Component.onCompleted: {
            // assigning the closeMenu() function from "Main.qml" to closeMenu property from "MenuList.qml"
            sessionmenu.closeMenu = mainroot.closeMenu;
        }
    }



    // LayoutMenu to choose a keyboard layout
    MenuList {
        id: layoutmenu
        // true = menu is visible; false = menu is invisible
        visible: false //false
        anchors.centerIn: parent

        // assign the number of menu items to the menu property
        items_count: keyboard.layouts.length
        // set the default layout index to the last keyboard layout
        item_index: keyboard.currentLayout

        // type of a menu
        menu_type: "layout"

        // do actions when component is completed
        Component.onCompleted: {
            // assigning the closeMenu() function from "Main.qml" to closeMenu property from "MenuList.qml"
            layoutmenu.closeMenu = mainroot.closeMenu;
        }
    }





    // UserList to choose a user
    MenuList {
        id: userlist
        // true = menu is visible; false = menu is invisible
        visible: false //false
        anchors.centerIn: parent

        // assign the number of menu items to the menu property
        items_count: userModel.count
        // set the default layout index to the last keyboard layout
        item_index: userModel.lastIndex

        // type of a menu
        menu_type: "userlist"

        // do actions when component is completed
        Component.onCompleted: {
            // assigning the closeMenu() function from "Main.qml" to closeMenu property from "MenuList.qml"
            userlist.closeMenu = mainroot.closeMenu;
        }
    }





    // BOTTOM BUTTONS
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    BottomButtons {
        id: bottombuttons

        // place it on the bottom of screen; horizontaly centered
        anchors.bottom: mainroot.bottom
        //anchors.bottomMargin: 40
        anchors.horizontalCenter: mainroot.horizontalCenter
    }

} // MAIN RECTANGLE END
