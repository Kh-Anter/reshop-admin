import 'package:flutter/material.dart';

import 'package:responsivedashboard/provider/page_controller.dart';

import 'package:responsivedashboard/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsivedashboard/widgets/search.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    var pageController = Provider.of<CurrentPageController>(context);
    return Scaffold(
        appBar: AppBar(actions: const [Spacer(), Expanded(child: Search())]),
        drawer: const MyDrawer(),
        body: SafeArea(
          child: pageController.currentPage,
        ));
  }
}
