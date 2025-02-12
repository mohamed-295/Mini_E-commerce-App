import 'package:flutter/material.dart';

class GridViewBuilder<T> extends StatelessWidget {
  final List<T> items;
  final int? length;
  final Widget Function(BuildContext, T, int) itemBuilder;

  const GridViewBuilder({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.length,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text('No items available'));
    }

    final itemCount = length ?? items.length;
    if (itemCount > items.length) {
      return Center(child: Text('Invalid length parameter'));
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1, 
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index], index);
      },
    );
  }
}