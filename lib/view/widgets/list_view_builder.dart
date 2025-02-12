import 'package:flutter/material.dart';

class ListViewBuilder<T> extends StatelessWidget {
  final List<T> items;
  final int? length;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Axis scrollDirection;
  final double listWidth;
  final double listHeight;

  const ListViewBuilder({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.length,
    this.scrollDirection = Axis.horizontal,
    required this.listWidth,
    required this.listHeight,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = length != null && length! < items.length ? length! : items.length;

    Widget listView = ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(width: 10),
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index], index);
      },
    );

    if (scrollDirection == Axis.horizontal) {
      listView = SizedBox(
        height: listHeight + 40,
        child: listView,
      );
    }

    return listView;
  }
}