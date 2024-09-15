import 'package:flutter/material.dart';
import 'package:cy_cube/view/course_page.dart';
import 'package:cy_cube/view/lab.dart';
import 'package:cy_cube/cube/cube_view/cube.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final CubeState _cubeState = CubeState();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    const CoursePage(),
    const Lab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CyCube'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Course System',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Lab',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: GestureDetector(
        onPanUpdate: (detail) {
          Provider.of<CubeState>(context, listen: false)
              .listenToArrange(detail: detail);
        },
        child: Transform(
          origin: const Offset(0, 0),
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateX(Provider.of<CubeState>(context).cubeDy * pi / 180)
            ..rotateY(Provider.of<CubeState>(context).cubeDx * pi / 180)
            ..setEntry(2, 2, 0.001),
          child: Center(
            child: Cube(),
          ),
        ),
      ),
    );
  }
}
