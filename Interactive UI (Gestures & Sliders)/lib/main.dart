import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorMixerScreen(),
    );
  }
}

class ColorMixerScreen extends StatefulWidget {
  @override
  _ColorMixerScreenState createState() => _ColorMixerScreenState();
}

class _ColorMixerScreenState extends State<ColorMixerScreen> {

  
  double r = 0, g = 0, b = 0;
  double boxSize = 150;

  
  String getHex() {
    String red = r.toInt().toRadixString(16).padLeft(2, '0');
    String green = g.toInt().toRadixString(16).padLeft(2, '0');
    String blue = b.toInt().toRadixString(16).padLeft(2, '0');
    return "#$red$green$blue";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mood & Color Mixer")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

           
           
            GestureDetector(
              onLongPress: () {
                String hex = getHex();
                print("Copied Hex: $hex");

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Hex Copied: $hex")),
                );
              },

              onHorizontalDragUpdate: (details) {
                setState(() {
                  boxSize += details.delta.dx;
                  boxSize = boxSize.clamp(50, 300);
                });
              },

              child: Container(
                width: boxSize,
                height: boxSize,
                color: Color.fromRGBO(
                  r.toInt(),
                  g.toInt(),
                  b.toInt(),
                  1,
                ),
              ),
            ),

            SizedBox(height: 20),

            
            Text(
              "HEX: ${getHex()}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 20),

            Text("Red: ${r.toInt()}"),
            Slider(
              min: 0,
              max: 255,
              value: r,
              onChanged: (val) => setState(() => r = val),
            ),

            
            Text("Green: ${g.toInt()}"),
            Slider(
              min: 0,
              max: 255,
              value: g,
              onChanged: (val) => setState(() => g = val),
            ),

          
            Text("Blue: ${b.toInt()}"),
            Slider(
              min: 0,
              max: 255,
              value: b,
              onChanged: (val) => setState(() => b = val),
            ),
          ],
        ),
      ),
    );
  }
}