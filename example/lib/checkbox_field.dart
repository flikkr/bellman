import 'package:flutter/material.dart';

class CheckboxField extends StatefulWidget {
  final Widget title;
  final bool initialValue;
  final void Function(bool value)? onChanged;

  const CheckboxField({
    super.key,
    required this.title,
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
              widget.onChanged?.call(value!);
            });
          },
        ),
        const SizedBox(width: 4.0),
        widget.title,
      ],
    );
  }
}
