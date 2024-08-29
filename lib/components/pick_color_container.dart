import 'package:flutter/material.dart';

class PickColorContainer extends StatelessWidget {
  const PickColorContainer({
    super.key,
    required this.color,
    required this.onTap,
    this.borderColor,
  });

  final Color color;
  final VoidCallback onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor ?? const Color(0xFF000000),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
