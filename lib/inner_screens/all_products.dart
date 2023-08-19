import 'package:flutter/material.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/responsive/responsive_layout.dart';
import 'package:responsivedashboard/util/utils.dart';
import 'package:responsivedashboard/widgets/custom_gridview.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key? key}) : super(key: key);
  static const title = "All products";

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return SingleChildScrollView(
      child: ResponsiveLayout(
        mobileBody: CustomGridView(
          childType: girdviewChildType.product,
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 && size.width > 350 ? 1.1 : 0.8,
          isInMain: false,
        ),
        tabletBody: CustomGridView(
          childType: girdviewChildType.product,
          crossAxisCount: 3,
          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
          isInMain: false,
        ),
        desktopBody: CustomGridView(
          childType: girdviewChildType.product,
          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
          isInMain: false,
        ),
      ),
    );
  }
}
