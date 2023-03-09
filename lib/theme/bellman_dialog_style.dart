import 'package:flutter/material.dart';

/// Style class for defining the UI of the Bellman dialog
/// 
/// Specify the color of the headline by using [titleBackgroundColor]. [dialogBackgroundColor]
/// is the background color of the dialog content. [borderRadius] will define the border radius
/// of the dialog corners.
class BellmanDialogStyle {
  final Color? titleBackgroundColor;
  final Color? dialogBackgroundColor;
  final BorderRadiusGeometry? borderRadius;

  BellmanDialogStyle({
    this.dialogBackgroundColor,
    this.borderRadius,
    this.titleBackgroundColor,
  });

  BellmanDialogStyle copyWith({
    Color? titleBackgroundColor,
    Color? dialogBackgroundColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return BellmanDialogStyle(
      titleBackgroundColor: titleBackgroundColor ?? this.titleBackgroundColor,
      dialogBackgroundColor: dialogBackgroundColor ?? this.dialogBackgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
