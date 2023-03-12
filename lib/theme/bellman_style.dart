import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

/// Style class for defining the UI of the Bellman widget
///
/// Specify the color of the headline by using [titleBackgroundColor]. [backgroundColor]
/// is the background color of the dialog content. [dialogBorderRadius] will define the border radius
/// of the dialog corners. [chipBackgroundColor] and [chipSelectedColor] define the background
/// and selected color of the category chip buttons.
class BellmanStyle {
  final Color? titleBackgroundColor;
  final Color? backgroundColor;
  final Color? chipBackgroundColor;
  final Color? chipSelectedColor;
  final BorderRadiusGeometry dialogBorderRadius;

  BellmanStyle({
    this.backgroundColor,
    this.titleBackgroundColor,
    this.chipBackgroundColor,
    this.chipSelectedColor,
    BorderRadiusGeometry? borderRadius,
  }) : dialogBorderRadius = BorderRadius.circular(kDialogBorderRadius);

  BellmanStyle copyWith({
    Color? titleBackgroundColor,
    Color? backgroundColor,
    Color? chipBackgroundColor,
    Color? chipSelectedColor,
    BorderRadiusGeometry? dialogBorderRadius,
  }) {
    return BellmanStyle(
      titleBackgroundColor: titleBackgroundColor ?? this.titleBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      chipBackgroundColor: chipBackgroundColor ?? this.chipBackgroundColor,
      chipSelectedColor: chipSelectedColor ?? this.chipSelectedColor,
      borderRadius: dialogBorderRadius ?? this.dialogBorderRadius,
    );
  }
}
