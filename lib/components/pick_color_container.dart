import 'package:flutter/material.dart';

class PickColorContainer extends StatelessWidget {
  const PickColorContainer({
    super.key,
    required this.color,
    required this.onTap,
  });
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}