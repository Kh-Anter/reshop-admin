import 'package:flutter/material.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/inner_screens/home.dart';
import 'package:responsivedashboard/size_config.dart';

class CurrentPageController with ChangeNotifier {
  Widget currentPage = Home();
  String currentTitle = myDrawerItems[0]["title"];
  int x = 1;

  changeCurrentPage(Widget newPage, String newTitle, BuildContext context) {
    currentPage = newPage;
    currentTitle = newTitle;
    if (!SizeConfig.isDesktop(context)) {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }
}
