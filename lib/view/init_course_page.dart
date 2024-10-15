import 'package:cy_cube/cube/cube_model/single_cube_component_face_model.dart';
import 'package:cy_cube/cube/cube_state.dart';
import 'package:provider/provider.dart';
import 'package:cy_cube/view/cube_setup_page_auto.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InitCoursePage extends StatefulWidget {
  const InitCoursePage({super.key});

  @override
  State<InitCoursePage> createState() => _InitCoursePageState();
}

class _InitCoursePageState extends State<InitCoursePage> {
  TextEditingController roomIDController = TextEditingController();
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              const Gap(30),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: roomIDController,
                      decoration: InputDecoration(
                        labelText: 'Room ID',
                        prefixIcon: const Icon(Icons.numbers),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    const Gap(10),
                    SizedBox(
                      width:
                          double.infinity, // Match the width of the TextField
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoad = true;
                          });

                          setState(() {
                            isLoad = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                          foregroundColor: Colors.white, // Text color
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Join the Room ( Teacher )'),
                      ),
                    ),
                    const Gap(10),
                    SizedBox(
                      width:
                          double.infinity, // Match the width of the TextField
                      child: ElevatedButton(
                        onPressed: () async {
                          var data = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CubeSetupPageAuto()));
                          List<List<SingleCubeComponentFaceModel>> cubeFaces =
                              data[0];
                          Provider.of<CubeState>(context, listen: false)
                              .setupCubeWithScanningColor(cubeFaces);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey, // Background color
                          foregroundColor: Colors.white, // Text color
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                            'Cube init & Create the Room ( Student )'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
