import 'package:flutter/material.dart';

/* --------------------------------- Spacing -------------------------------- */
const SizedBox yGap = SizedBox(height: spacingValue);
const SizedBox xGap = SizedBox(width: spacingValue);

const double spacingValue = 4.0;
const double paddingValue = 10.0;

const double smallBreakpoint = 480.0;
const double mediumBreakpoint = 768.0;
const double largeBreakpoint = 1024.0;

/* --------------------------------- Dialog --------------------------------- */
const double kDialogBorderRadius = 8.0;
const Color kDialogBarrierColor = Colors.black54;
const bool kDialogBarrierDismissible = false;
const Duration kDialogTransitionDuration = Duration(milliseconds: 200);
const BoxConstraints kDialogConstraints = BoxConstraints(maxWidth: 600, maxHeight: 500);

const String dialogHeadlineText = "What's new!";
