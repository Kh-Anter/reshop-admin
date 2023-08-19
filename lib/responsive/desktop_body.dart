import 'package:flutter/material.dart';
import 'package:responsivedashboard/provider/page_controller.dart';
import 'package:responsivedashboard/util/utils.dart';

import 'package:responsivedashboard/widgets/drawer.dart';
import 'package:responsivedashboard/widgets/search.dart';

import 'package:provider/provider.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    var pageController = Provider.of<CurrentPageController>(context);
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyDrawer(),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  desktopHeader(title: pageController.currentTitle),
                  SizedBox(
                      height: size.height - 70,
                      child: pageController.currentPage)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  desktopHeader({required String title}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Spacer(flex: 2),
        const Expanded(child: Search()),
      ],
    );
  }
}
