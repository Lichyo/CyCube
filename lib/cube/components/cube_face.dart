import 'package:flutter/material.dart';

class CubeFace extends StatelessWidget {
  const CubeFace({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 90,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
