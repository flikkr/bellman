
import 'package:bellman/components/dialog/bellman_dialog_chip_list.dart';
import 'package:bellman/data/bellman_category.dart';
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
        BellmanDialogChipList(
          categories: widget.categories.map((cat) => cat.displayTitle).toList(),
          initialIndex: selectedIndex,
          onTap: (index) {
            controller.jumpToPage(index);
          },
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
}
