import 'package:cy_cube/cube/cube_state.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_view/cube_page.dart';
import 'package:provider/provider.dart';
import 'package:cy_cube/view/course_page.dart';
import 'package:cy_cube/view/lab.dart';
import 'dart:core';
import 'package:camera/camera.dart';
import 'package:cy_cube/view/home_page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _selectedIndex = 0;
  final CubeState _cubeState = CubeState();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [];
  List<int> executionTimes = [];
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const HomePage(),
      const CoursePage(),
      const Lab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onPanUpdate: (detail) {
            Provider.of<CubeState>(context, listen: false)
                .listenToArrange(detail: detail);
          },
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Course',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: 'Lab',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            body: _pages[_selectedIndex],
          ),
        );
      },
    );
  }
}
