import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/inner_screens/add_prod.dart';
import 'package:responsivedashboard/provider/page_controller.dart';
import 'package:responsivedashboard/responsive/responsive_layout.dart';
import 'package:responsivedashboard/util/utils.dart';
import 'package:responsivedashboard/widgets/buttons.dart';
import 'package:responsivedashboard/widgets/custom_gridview.dart';
import 'package:responsivedashboard/widgets/orders_list.dart';

import 'package:responsivedashboard/widgets/textwidget.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    var pageController = Provider.of<CurrentPageController>(context);
    Color color = Utils(context).color;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextWidget(text: 'Latest Products', color: color),
            const SizedBox(height: 15),
            _addAndViewBtns(pageController, context),
            _body(size),
          ],
        ),
      ),
    );
  }

  Widget _addAndViewBtns(pageController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ButtonsWidget(
              onPressed: () {},
              text: 'View All',
              icon: Icons.store,
              backgroundColor: primaryColor),
          const Spacer(),
          ButtonsWidget(
              onPressed: () {
                pageController.changeCurrentPage(
                    const UploadProductForm(), "Add product", context);
              },
              text: 'Add product',
              icon: Icons.add,
              backgroundColor: primaryColor),
        ],
      ),
    );
  }

  Widget _body(size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              ResponsiveLayout(
                mobileBody: CustomGridView(
                  childType: girdviewChildType.product,
                  crossAxisCount: size.width < 650 ? 2 : 4,
                  childAspectRatio:
                      size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                ),
                tabletBody: CustomGridView(
                  childType: girdviewChildType.product,
                  childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                ),
                desktopBody: CustomGridView(
                  childType: girdviewChildType.product,
                  childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: OrdersList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
