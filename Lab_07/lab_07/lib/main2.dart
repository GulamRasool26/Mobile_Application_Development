import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SliderScreen(),
    );
  }
}

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {

  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sliders ")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            
            Text(
              "Value: ${value.toStringAsFixed(1)}",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 20),

            
            Slider(
              min: 0.0,
              max: 100.0,
              divisions: 10,
              value: value,
              label: value.toStringAsFixed(1),
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),

            SizedBox(height: 20),

          
            CupertinoSlider(
              min: 0.0,
              max: 100.0,
              value: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}