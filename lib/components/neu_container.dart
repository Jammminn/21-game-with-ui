import 'package:flutter/material.dart';

// Basic container that looks neumorphic.
class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final Color? shadow;
  final Color? highlight;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double shadowSize;
  final double highlightSize;
  final double blurRadius;

  const NeumorphicContainer(
      {super.key,
      required this.child,
      this.shadow,
      this.highlight,
      this.color,
      this.margin,
      this.padding,
      this.borderRadius,
      this.shadowSize = 2,
      this.highlightSize = 2,
      this.blurRadius = 4});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color ?? theme.background,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: highlight ?? theme.surfaceTint,
            offset: Offset(-highlightSize, -highlightSize),
            blurRadius: blurRadius,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: shadow ?? theme.shadow,
            offset: Offset(shadowSize, shadowSize),
            blurRadius: blurRadius,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
