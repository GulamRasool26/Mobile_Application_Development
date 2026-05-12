import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureScreen(),
    );
  }
}

class GestureScreen extends StatefulWidget {
  @override
  _GestureScreenState createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  Color boxColor = Colors.blue;
  double borderRadius = 0;

  void resetBox() {
    setState(() {
      boxColor = Colors.blue;
      borderRadius = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gesture Detector")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              boxColor = Colors.primaries[
                  Random().nextInt(Colors.primaries.length)];
            });
          },
          onDoubleTap: () {
            setState(() {
              borderRadius = borderRadius == 0 ? 100 : 0;
            });
          },
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Resetting...")),
            );
            resetBox();
          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}