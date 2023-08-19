import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsivedashboard/provider/page_controller.dart';
import 'package:responsivedashboard/widgets/drawer.dart';
import 'package:responsivedashboard/widgets/search.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    var pageController = Provider.of<CurrentPageController>(context);

    return Scaffold(
        // backgroundColor: defaultBackgroundColor,
        appBar: AppBar(actions: const [Spacer(), Expanded(child: Search())]),
        drawer: const MyDrawer(),
        body: SafeArea(
          child: pageController.currentPage,
        ));
  }
}
