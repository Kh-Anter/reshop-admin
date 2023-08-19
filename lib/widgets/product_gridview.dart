import 'package:flutter/material.dart';

import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/widgets/myCustomCard.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView(
      {required this.childType,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      required this.itemCount,
      Key? key})
      : super(key: key);

  final girdviewChildType childType;
  final int crossAxisCount;
  final double childAspectRatio;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: childAspectRatio,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding),
        itemBuilder: (context, index) => MyCustomCard(cartType: childType));
  }
}
