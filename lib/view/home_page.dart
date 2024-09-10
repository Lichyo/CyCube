import 'package:cy_cube/components/cube_state_in_2D.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:cy_cube/components/cube_rotation_table.dart';
import 'package:flutter/material.dart';
import 'package:cy_cube/cube/cube_view/cube.dart';
import 'dart:math';
import 'package:gap/gap.dart';
import 'package:cy_cube/service/database_service.dart';
import 'package:provider/provider.dart';
import 'package:cy_cube/view/course_page.dart';
import 'package:cy_cube/view/lab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    Cube(),
    const CoursePage(),
    const Lab(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CyCube'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
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
        body: Center(
          child: _pages[_selectedIndex],
        ),
      ),
    );
  }
}
