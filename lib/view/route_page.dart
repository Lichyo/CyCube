import 'package:cy_cube/cube/cube_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cy_cube/view/course_page.dart';
import 'package:cy_cube/view/lab.dart';
import 'dart:core';
import 'package:camera/camera.dart';
import 'package:cy_cube/view/home_page.dart';
import 'package:gap/gap.dart';
import 'package:cy_cube/config.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [];
  List<int> executionTimes = [];
  late List<CameraDescription> cameras;
  String ip = "";
  String port = "";

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
            // floatingActionButton: FloatingActionButton(
            //   child: const Icon(Icons.connected_tv_rounded),
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) => AlertDialog(
            //         content: SizedBox(
            //           height: 300,
            //           child: Column(
            //             children: [
            //               Text(
            //                 Config.serverIP,
            //                 style: const TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               TextField(
            //                 onChanged: (value) {
            //                   ip = value;
            //                 },
            //                 keyboardType: TextInputType.number,
            //                 decoration: InputDecoration(
            //                   labelText: 'Enter your IP address',
            //                   prefixIcon: const Icon(Icons.wifi),
            //                   border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(8.0),
            //                   ),
            //                 ),
            //               ),
            //               const Gap(10),
            //               TextField(
            //                 onChanged: (value) {
            //                   port = value;
            //                 },
            //                 keyboardType: TextInputType.number,
            //                 decoration: InputDecoration(
            //                   labelText: 'Enter your port number',
            //                   prefixIcon: const Icon(Icons.numbers),
            //                   border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(8.0),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         actions: [
            //           ElevatedButton(
            //             onPressed: () {
            //               Navigator.of(context).pop();
            //             },
            //             child: const Text('Cancel'),
            //           ),
            //           ElevatedButton(
            //             onPressed: () {
            //               Config.setIP(ip, port);
            //               Navigator.of(context).pop();
            //             },
            //             child: const Text('Connect'),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
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
