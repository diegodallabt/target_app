import 'package:flutter/material.dart';

class AnimatedFormField extends StatelessWidget {
  final Widget child;

  const AnimatedFormField({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: child,
    );
  }
}
