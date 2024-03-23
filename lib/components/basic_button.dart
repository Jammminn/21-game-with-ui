import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const BasicButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.color,
      this.borderRadius,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: borderRadius ??
            const BorderRadius.all(
              Radius.circular(12),
            ),
        child: Container(
          color: color ?? Colors.transparent,
          margin: margin,
          padding: padding,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
