import 'dart:math';

import 'package:cy_cube/cube/cube_constants.dart';
import 'package:flutter/material.dart';

enum ArrowDirection { up, down, left, right, none }

class ArrowAnimate extends StatefulWidget {
  ArrowDirection arrowState;
  ArrowAnimate({super.key, required this.arrowState});

  @override
  _ArrowAnimateState createState() => _ArrowAnimateState();
}

class _ArrowAnimateState extends State<ArrowAnimate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _animationEnd = 0;
  final Offset _arrowOffset = const Offset(0, 3);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _updateAnimation(widget.arrowState);
    _controller.forward();
  }

  @override
  void didUpdateWidget(ArrowAnimate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.arrowState != oldWidget.arrowState) {
      _updateAnimation(widget.arrowState);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateParameter(ArrowDirection arrowState) {
    switch (arrowState) {
      case ArrowDirection.up:
        _animationEnd = -8;
        break;
      case ArrowDirection.right:
        _animationEnd = 8;
        break;
      case ArrowDirection.down:
        _animationEnd = 8;
        break;
      case ArrowDirection.left:
        _animationEnd = -8;
        break;
      default:
        _animationEnd = 0;
    }
  }

  void _updateAnimation(ArrowDirection arrowState) {
    _updateParameter(arrowState);
    _animation =
    Tween<double>(begin: 0, end: _animationEnd).animate(_controller)
      ..addListener(() {
        if (_controller.isCompleted) {
          _controller.reset();
          _controller.forward();
        }
      });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double rotationAngle = 0;
    switch (widget.arrowState) {
      case ArrowDirection.up:
        rotationAngle = 0;
        break;
      case ArrowDirection.right:
        rotationAngle = pi / 2;
        break;
      case ArrowDirection.down:
        rotationAngle = pi;
        break;
      case ArrowDirection.left:
        rotationAngle = -pi / 2;
        break;
      default:
        rotationAngle = 0;
    }

    return SizedBox(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: (widget.arrowState == ArrowDirection.up ||
                widget.arrowState == ArrowDirection.down)
                ? Offset(0, _animation.value)
                : Offset(_animation.value, 0),
            child: child,
          );
        },
        child: Transform.rotate(
          angle: rotationAngle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.translate(
                offset: _arrowOffset,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black,
                  size: cubeWidth * 0.6,
                ),
              ),
              Transform.translate(
                offset: _arrowOffset,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black,
                  size: cubeWidth * 0.6,
                ),
              ),
              Transform.translate(
                offset: _arrowOffset,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black,
                  size: cubeWidth * 0.6,
                ),
              ),
              Transform.translate(
                offset: _arrowOffset,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black,
                  size: cubeWidth * 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
