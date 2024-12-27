// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shut_down/Const.dart';
import 'dart:io';
import 'package:number_selector/number_selector.dart';
import 'package:shut_down/Info_Page.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  double gpu_temp = 0;
  bool started = false;
  String stateText = "Ready";
  double gpuTemperature =
      0.0; // Temperature as a percentage (0.0 to 1.0)
  int gpuTempLimit = 45;
  @override
  void initState() {
    super.initState();

    fetchGpuTemperature();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void check_temp() {
    fetchGpuTemperature();
    if (started == true) {
      if (gpuTemperature.toInt() < gpuTempLimit) {
        stateText =
            'Cool as a cucumber! Your system\'s temperature is just right. Shuting Down in 60 seconds...👋🏻';

        // Process.run('shutdown', ['-s', '-t', '60']);
      } else {
        setState(() {
          stateText =
              "GPU temperature is high!\nCooling down in progress...\n stay frosty! 🥵";
        });
      }
    } else {
      stateText = "Ready to roll! 🚀";
    }
  }

  void fetchGpuTemperature() async {
    try {
      // Run the nvidia-smi command to fetch GPU temperature
      var result = await Process.run(
        'nvidia-smi',
        [
          '--query-gpu=temperature.gpu',
          '--format=csv,noheader,nounits'
        ],
      );

      if (result.exitCode == 0) {
        // Parse the output
        String tempOutput = result.stdout.trim();
        double temperature = double.tryParse(tempOutput) ?? 0.0;

        // Update the state to refresh the UI
        setState(() {
          gpuTemperature =
              temperature; // Convert to percentage (0.0 to 1.0)
        });
        print(gpuTemperature);
      } else {
        print('Error fetching GPU temperature: ${result.stderr}');
      }
    } catch (e) {
      print('Failed to fetch GPU temperature: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Info_Page()));
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.white60,
              ))
        ],
        title: const Text("CoolDown", style: textstyle),
        centerTitle: true,
        backgroundColor: background_color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    stateText,
                    textAlign: TextAlign.center,
                    style: statestyle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SimpleAnimationProgressBar(
                    // border: Border.all(color: Colors.green),
                    height: 30,

                    gradientColor: const LinearGradient(
                        colors: [Colors.green, Colors.red]),
                    foregrondColor: Colors.yellow,
                    width: 300,
                    backgroundColor: Colors.grey.shade800,
                    ratio: gpuTemperature / 100,
                    direction: Axis.horizontal,
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(seconds: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("GPU Temp :", style: footerstyle),
                      Text(
                        "  ${gpuTemperature.toInt()} °C",
                        style: footerstyle.copyWith(
                            color: gpuTemperature < gpuTempLimit
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 240,
              child: NumberSelector(
                current: gpuTempLimit,
                min: 1,
                showMinMax: false,
                max: 100,
                onUpdate: (val) {
                  check_temp();
                  setState(() {
                    gpuTempLimit = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        started ? Colors.red : background_color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      started = !started;
                    });
                    check_temp();
                    Timer.periodic(Duration(seconds: 10), (timer) {
                      if (!started) {
                        timer.cancel(); // Stop the timer
                      } else {
                        check_temp();
                      }
                    });
                  },
                  icon: Icon(
                    started
                        ? Icons.pause_circle
                        : Icons.play_circle_fill,
                    color: Colors.white,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(started ? "Stop" : "Start",
                        style: buttonstyle),
                  )),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 23, 20, 30),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Process.run('shutdown', ['-s', '-t', '60']);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Shut Down", style: textstyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
