import 'package:flutter/material.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/responsive/responsive_layout.dart';
import 'package:responsivedashboard/util/utils.dart';
import 'package:responsivedashboard/widgets/custom_gridview.dart';
import 'package:responsivedashboard/widgets/textwidget.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Utils(context).color;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextWidget(text: 'All users', color: color),
            const SizedBox(height: 15),
            _body(size),
          ],
        ),
      ),
    );
  }

  Widget _body(size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          //   flex: 5,
          child: ResponsiveLayout(
            mobileBody: CustomGridView(
              childType: girdviewChildType.user,
              crossAxisCount: size.width < 650 ? 2 : 4,
              childAspectRatio:
                  size.width < 650 && size.width > 350 ? 1.1 : 0.8,
            ),
            tabletBody: CustomGridView(
              childType: girdviewChildType.user,
              childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
            ),
            desktopBody: CustomGridView(
              childType: girdviewChildType.user,
              childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
            ),
          ),
        ),
      ],
    );
  }
}
