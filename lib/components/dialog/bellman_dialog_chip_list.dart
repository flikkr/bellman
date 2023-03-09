import 'dart:io';

import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

class BellmanDialogChipList extends StatefulWidget {
  final List<String> categories;
  final int initialIndex;
  final void Function(int index)? onTap;

  const BellmanDialogChipList({
    super.key,
    required this.categories,
    this.initialIndex = 0,
    this.onTap,
  });

  @override
  State<BellmanDialogChipList> createState() => _BellmanDialogChipListState();
}

class _BellmanDialogChipListState extends State<BellmanDialogChipList> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: paddingValue,
        vertical: Platform.isAndroid || Platform.isIOS ? paddingValue / 2 : paddingValue,
      ),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _mapCategoryToChip(),
      ),
    );
  }

  List<Widget> _mapCategoryToChip() {
    final categories = widget.categories;
    List<Widget> chips = [];
    for (int i = 0; i < categories.length; i++) {
      chips.add(
        ChoiceChip(
          pressElevation: 4,
          label: Text(categories[i]),
          selected: index == i,
          onSelected: (value) {
            setState(() {
              index = i;
              widget.onTap?.call(i);
            });
          },
        ),
      );
      if (i != widget.categories.length) {
        chips.add(xGap);
      }
    }
    return chips;
  }
}
