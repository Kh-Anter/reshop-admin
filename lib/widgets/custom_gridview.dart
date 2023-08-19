import 'package:flutter/material.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/widgets/myCustomCard.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.isInMain = true,
    required this.childType,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;
  final girdviewChildType childType;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: isInMain ? 4 : 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
        ),
        itemBuilder: (context, index) {
          return MyCustomCard(
            cartType: childType,
          );
        });
  }
}
