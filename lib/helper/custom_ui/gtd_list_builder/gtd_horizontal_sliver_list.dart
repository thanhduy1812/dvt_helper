import 'package:flutter/material.dart';

/// Only using for small size (<= 5 items) List for performance
class GtdHorizontalSliverList extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets listPadding;
  final Widget? divider;

  const GtdHorizontalSliverList({
    Key? key,
    required this.children,
    this.listPadding = const EdgeInsets.all(8),
    this.divider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: listPadding,
          child: Row(children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) addDivider(),
            ],
          ]),
        ),
      ),
    );
  }

  Widget addDivider() => divider ?? const Padding(padding: EdgeInsets.symmetric(horizontal: 8));
}
