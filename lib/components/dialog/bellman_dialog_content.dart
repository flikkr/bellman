import 'dart:io';

import 'package:bellman/data/bellman_category.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

class BellmanDialogContent extends StatefulWidget {
  final List<BellmanCategory> categories;

  const BellmanDialogContent({
    super.key,
    required this.categories,
  });

  @override
  State<BellmanDialogContent> createState() => _BellmanDialogContentState();
}

class _BellmanDialogContentState extends State<BellmanDialogContent> {
  int selectedIndex = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: paddingValue,
            vertical: Platform.isAndroid || Platform.isIOS ? paddingValue / 2 : paddingValue,
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _mapCategoryToChip(),
          ),
        ),
        Expanded(
          child: PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.categories
                .map(
                  (category) => category.content?.display(context) ?? Container(),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  List<Widget> _mapCategoryToChip() {
    final categories = widget.categories;
    List<Widget> chips = [];
    for (int i = 0; i < categories.length; i++) {
      chips.add(
        ChoiceChip(
          pressElevation: 4,
          label: Text(categories[i].displayTitle),
          selected: selectedIndex == i,
          onSelected: (value) {
            setState(() {
              selectedIndex = i;
              controller.jumpToPage(i);
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
