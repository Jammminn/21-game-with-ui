import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_21_ui/components/basic_button.dart';

//  Basic horizontal radio buttons that show whats been selected with a different color.
class BasicRadioButtons extends StatefulWidget {
  final List<RadioButtonData> buttons;
  final Widget? separator;
  final Color? color;
  final Color? selectedColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? innerButtonRadius;

  String? selectedValue;

  BasicRadioButtons(
      {required this.buttons,
      super.key,
      this.separator,
      this.color,
      this.selectedColor,
      this.borderRadius,
      this.margin,
      this.padding,
      this.selectedValue,
      this.innerButtonRadius});

  @override
  State<BasicRadioButtons> createState() => _BasicRadioButtonsState();
}

class _BasicRadioButtonsState extends State<BasicRadioButtons> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetSections = [];

    for (int i = 0; i < widget.buttons.length; i++) {
      RadioButtonData buttonInfo = widget.buttons[i];
      widgetSections.add(
        Expanded(
          child: _buildButton(buttonInfo),
        ),
      );
      if (widget.separator != null && 0 < i && i < widget.buttons.length - 1) {
        widgetSections.add(widget.separator!);
      }
    }

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        color: widget.color,
        child: Row(
          children: widgetSections,
        ),
      ),
    );
  }

  // builds the button
  Widget _buildButton(RadioButtonData buttonInfo) {
    return BasicButton(
      borderRadius: widget.innerButtonRadius,
      onPressed: () {
        setState(() {
          widget.selectedValue = buttonInfo.value;
        });
        buttonInfo.onPressed();
      },
      color: buttonInfo.value == widget.selectedValue
          ? widget.selectedColor
          : widget.color,
      child: buttonInfo.text,
    );
  }
}

class RadioButtonData {
  final String value;
  final Text text;
  final void Function() onPressed;

  RadioButtonData({
    required this.value,
    required this.text,
    required this.onPressed,
  });

  @override // easier for comparing current value and the value in here
  bool operator ==(Object other) {
    return other is String && other == value ? true : false;
  }

  @override
  int get hashCode => value.hashCode;
}
