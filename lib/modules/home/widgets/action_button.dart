import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double? size;

  const ActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Icon(icon, size: size ?? 32, color: color),
    );
  }
}
