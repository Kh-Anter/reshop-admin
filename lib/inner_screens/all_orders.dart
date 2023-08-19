import 'package:flutter/material.dart';
import 'package:responsivedashboard/widgets/orders_list.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({Key? key}) : super(key: key);
  static const title = "All orders";

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: OrdersList(),
            ),
          ),
        )
      ],
    );
  }
}
