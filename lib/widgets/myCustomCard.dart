import 'package:flutter/material.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/util/utils.dart';
import 'package:responsivedashboard/widgets/textwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyCustomCard extends StatefulWidget {
  final girdviewChildType cartType;

  const MyCustomCard({required this.cartType, Key? key}) : super(key: key);

  @override
  State<MyCustomCard> createState() => _MyCustomCardState();
}

class _MyCustomCardState extends State<MyCustomCard> {
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Flexible(
                            flex: 3,
                            child: widget.cartType == girdviewChildType.product
                                ? CachedNetworkImage(
                                    imageUrl: "https://picsum.photos/210/300",
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  )
                                : CircleAvatar(
                                    radius: 150,
                                    backgroundImage: NetworkImage(
                                      "https://picsum.photos/210/300",
                                    ))),
                        const Spacer(),
                      ],
                    ),
                    Positioned(right: 2, top: 2, child: popupMenu()),
                  ]),
                ),
                const SizedBox(
                  height: 2,
                ),
                widget.cartType == girdviewChildType.product
                    ? Row(
                        children: [
                          TextWidget(
                            text: '\$1.99',
                            color: color,
                            textSize: 18,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Visibility(
                              visible: true,
                              child: Text(
                                '\$3.89',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: color),
                              )),
                          const Spacer(),
                          TextWidget(
                            text: '1Kg',
                            color: color,
                            textSize: 18,
                          ),
                        ],
                      )
                    : Center(
                        child: TextWidget(
                          text: "sddsdss",
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuButton<int> popupMenu() {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {},
                value: 1,
                child: Text(widget.cartType == girdviewChildType.product
                    ? "edit"
                    :
                    // : widget.isDisabled
                    //     ? 'activate'
                    //     :
                    "disable"),
              ),
              PopupMenuItem(
                onTap: () {},
                value: 2,
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              // PopupMenuItem(
              //   onTap: () {},
              //   value: 3,
              //   child: const Text(
              //     'details',
              //     style: TextStyle(color: Colors.red),
              //   ),
              // ),
            ]);
  }
}
