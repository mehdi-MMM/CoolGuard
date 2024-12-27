import 'package:flutter/material.dart';
import 'package:shut_down/Const.dart';

class Info_Page extends StatelessWidget {
  const Info_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: background_color,
        centerTitle: true,
        title: const Text(
          "Info",
          style: textstyle,
        ),
      ),
      body: Container(
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Welcome to CoolGuard",
                style: infostyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "CoolGuard is your trusty sidekick for those moments when you're stepping away from your computer but want to ensure your GPU cools down safely.",
                style: infostyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "What We Do?",
                style: infostyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "We keep a close watch on your GPU temperature in real-time, so you don't have to.",
                style: infostyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "If your GPU temperature is high and you need to leave or sleep, our app stays running until the temperature drops below your specified limit.",
                style: infostyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Once the GPU temperature is safely within the desired range, CoolGuard will automatically shut down your computer, ensuring your hardware stays protected.",
                style: infostyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Because your GPU deserves to chill out as much as you do! 😎",
                style: infostyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
