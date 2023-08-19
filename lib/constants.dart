import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:responsivedashboard/inner_screens/all_admins.dart';
import 'package:responsivedashboard/inner_screens/all_orders.dart';
import 'package:responsivedashboard/inner_screens/all_products.dart';
import 'package:responsivedashboard/inner_screens/all_users.dart';
import 'package:responsivedashboard/inner_screens/categories.dart';
import 'package:responsivedashboard/inner_screens/home.dart';

const defaultPadding = 10.0;
const primaryColor = Color.fromRGBO(227, 52, 52, 0.8);
const primaryLightColor = Color.fromRGBO(227, 52, 52, 0.10);
const myTextFieldBackgroundColor = Color.fromRGBO(239, 239, 239, 1);
var drawerTextColor = Colors.grey[600];
const mySecondTextColor = Color.fromRGBO(0, 0, 0, 0.30);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

List<Map<String, dynamic>> myDrawerItems = const [
  {
    "title": "Home",
    "icon": Icon(Icons.home),
    "page": Home(),
  },
  {
    "title": "All products",
    "icon": Icon(Icons.store),
    "page": AllProducts(),
  },
  {
    "title": "Categories",
    "icon": Icon(IconlyBold.category),
    "page": Categories()
  },
  {
    "title": "Orders",
    "icon": Icon(IconlyBold.bag_2),
    "page": AllOrders(),
  },
  {
    "title": "Users",
    "icon": Icon(IconlyBold.user_3),
    "page": AllUsers(),
  },
  {
    "title": "Admins",
    "icon": Icon(IconlyBold.user_2),
    "page": AllAdmins(),
  },
];

enum girdviewChildType { user, admin, product }
