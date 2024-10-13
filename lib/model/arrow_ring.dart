import 'dart:math';
import 'arrow_state_model.dart';
import 'package:flutter/material.dart';
import 'arrow.dart';
import 'package:cy_cube/cube/cube_constants.dart';

enum Movement { u, d, f, b, r, l, uP, dP, fP, bP, rP, lP, none }

class ArrowRing extends StatefulWidget {
  ArrowRing({super.key, required this.movement});

  late Movement movement;

  @override
  State<ArrowRing> createState() => _ArrowRingState();
}

class _ArrowRingState extends State<ArrowRing> {
  late ArrowState firstSide = ArrowState(
      offsetX: 0,
      offsetY: 0,
      offsetZ: 0,
      rotateX: 0,
      rotateY: 0,
      rotateZ: 0,
      arrowDirection: ArrowDirection.none);
  late ArrowState secondSide = ArrowState(
      offsetX: 0,
      offsetY: 0,
      offsetZ: 0,
      rotateX: 0,
      rotateY: 0,
      rotateZ: 0,
      arrowDirection: ArrowDirection.none);
  late ArrowState thirdSide = ArrowState(
      offsetX: 0,
      offsetY: 0,
      offsetZ: 0,
      rotateX: 0,
      rotateY: 0,
      rotateZ: 0,
      arrowDirection: ArrowDirection.none);
  late ArrowState fourthSide = ArrowState(
      offsetX: 0,
      offsetY: 0,
      offsetZ: 0,
      rotateX: 0,
      rotateY: 0,
      rotateZ: 0,
      arrowDirection: ArrowDirection.none);

  void updateArrowStates() {
    if (widget.movement == Movement.u) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': -cubeWidth,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.left
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': -cubeWidth,
        'offsetZ': -cubeWidth * 0.75,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.right
      });
    } else if (widget.movement == Movement.uP) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': -cubeWidth,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.right
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': cubeWidth * 0.45,
        'offsetZ': -cubeWidth * 1.5,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.up
      });
    } else if (widget.movement == Movement.d) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': cubeWidth,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.right
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': cubeWidth,
        'offsetZ': -cubeWidth * 0.75,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.left
      });
    } else if (widget.movement == Movement.dP) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': cubeWidth,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.left
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': cubeWidth,
        'offsetZ': -cubeWidth * 0.75,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.right
      });
    } else if (widget.movement == Movement.f) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': -cubeWidth * 0.25,
        'offsetZ': -cubeWidth * 0.75,
        'rotateX': pi / 2,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.right
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': 0,
        'offsetZ': cubeWidth * 0.16,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.down
      });
    } else if (widget.movement == Movement.fP) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': -cubeWidth * 0.25,
        'offsetZ': -cubeWidth * 0.75,
        'rotateX': pi / 2,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.left
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': 0,
        'offsetZ': cubeWidth * 0.16,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.up
      });
    } else if (widget.movement == Movement.b) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': -cubeWidth * 0.25,
        'offsetZ': -cubeWidth * 2.75,
        'rotateX': pi / 2,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.left
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': 0,
        'offsetZ': -cubeWidth * 1.84,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.up
      });
    } else if (widget.movement == Movement.bP) {
      firstSide.updateValueFromMap({
        'offsetX': 0.0,
        'offsetY': -cubeWidth * 0.25,
        'offsetZ': -cubeWidth * 2.75,
        'rotateX': pi / 2,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.right
      });
      secondSide.updateValueFromMap({
        'offsetX': 2 * cubeWidth,
        'offsetY': 0,
        'offsetZ': -cubeWidth * 1.84,
        'rotateX': 0,
        'rotateY': -pi / 2,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.down
      });
    } else if (widget.movement == Movement.r) {
      firstSide.updateValueFromMap({
        'offsetX': cubeWidth,
        'offsetY': 0,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.up
      });
      secondSide.updateValueFromMap({
        'offsetX': cubeWidth,
        'offsetY': -cubeWidth * 0.25,
        'offsetZ': -cubeWidth * 1.75,
        'rotateX': pi / 2,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.up
      });
    } else if (widget.movement == Movement.rP) {
      firstSide.updateValueFromMap({
        'offsetX': cubeWidth,
        'offsetY': 0,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.down
      });
      secondSide.updateValueFromMap({
        'offsetX': cubeWidth,
        'offsetY': -cubeWidth * 0.25,
        'offsetZ': -cubeWidth * 1.75,
        'rotateX': pi / 2,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.down
      });
    } else if (widget.movement == Movement.l) {
      firstSide.updateValueFromMap({
        'offsetX': -cubeWidth,
        'offsetY': 0,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.down
      });
      secondSide.updateValueFromMap({
        'offsetX': -cubeWidth,
        'offsetY': -cubeWidth * 0.25,
        'offsetZ': -cubeWidth * 1.75,
        'rotateX': pi / 2,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.down
      });
    } else if (widget.movement == Movement.lP) {
      firstSide.updateValueFromMap({
        'offsetX': -cubeWidth,
        'offsetY': cubeWidth * 0.15,
        'offsetZ': cubeWidth,
        'rotateX': 0,
        'rotateY': 0,
        'arrowDirection': ArrowDirection.up
      });
      secondSide.updateValueFromMap({
        'offsetX': -cubeWidth * 0.4,
        'offsetY': -cubeWidth * 0.3,
        'offsetZ': -cubeWidth * 1.75,
        'rotateX': 0,
        'rotateY': pi,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.up
      });
    } else {
      firstSide.updateValueFromMap({
        'offsetX': 0,
        'offsetY': 0,
        'offsetZ': 0,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.none
      });
      secondSide.updateValueFromMap({
        'offsetX': 0,
        'offsetY': 0,
        'offsetZ': 0,
        'rotateX': 0,
        'rotateY': 0,
        'rotateZ': 0,
        'arrowDirection': ArrowDirection.none
      });
    }
  }

  @override
  void didUpdateWidget(ArrowRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      updateArrowStates();
    });
    // if (oldWidget.movement != widget.movement) {
    //   setState(() {
    //     updateArrowStates();
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    updateArrowStates();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.movement != Movement.none)
        ? Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                      firstSide.offsetX, firstSide.offsetY, firstSide.offsetZ)
                  ..rotateX(firstSide.rotateX)
                  ..rotateY(firstSide.rotateY)
                  ..rotateZ(firstSide.rotateZ),
                child: ArrowAnimate(arrowState: firstSide.arrowDirection),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(secondSide.offsetX, secondSide.offsetY,
                      secondSide.offsetZ)
                  ..rotateX(secondSide.rotateX)
                  ..rotateY(secondSide.rotateY)
                  ..rotateZ(secondSide.rotateZ),
                child: ArrowAnimate(arrowState: secondSide.arrowDirection),
              ),
            ],
          )
        : Stack();
  }
}
