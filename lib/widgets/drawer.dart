import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/provider/authentication_controller.dart';
import 'package:responsivedashboard/provider/page_controller.dart';
import 'package:responsivedashboard/provider/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageController = Provider.of<CurrentPageController>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.isDarkTheme;
    final authCtrl = Provider.of<AuthenticationController>(context);
    int drawerItemsLength = myDrawerItems.length;

    if (authCtrl.currentAdminRule == 1) {
      drawerItemsLength = myDrawerItems.length;
    } else if (authCtrl.currentAdminRule == 2) {
      drawerItemsLength = myDrawerItems.length - 1;
    }
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/splash.png"),
          )),
          ...List.generate(
            drawerItemsLength,
            (index) => Padding(
              padding: tilePadding,
              child: ListTile(
                leading: myDrawerItems[index]["icon"],
                title: Text(
                  myDrawerItems[index]["title"],
                  style: drawerTextStyle(pageController.currentTitle ==
                      myDrawerItems[index]["title"]),
                ),
                onTap: () {
                  pageController.changeCurrentPage(myDrawerItems[index]["page"],
                      myDrawerItems[index]["title"], context);
                },
              ),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: SwitchListTile(
                title: Text('Theme', style: drawerTextStyle(false)),
                secondary: Icon(themeProvider.isDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                value: theme,
                onChanged: (value) => themeProvider.changeTheme()),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'L O G O U T',
                style: drawerTextStyle(false),
              ),
              onTap: () {
                AuthenticationController.logOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  drawerTextStyle(bool isBold) {
    return TextStyle(
        fontWeight: isBold ? FontWeight.bold : null, color: drawerTextColor);
  }
}
