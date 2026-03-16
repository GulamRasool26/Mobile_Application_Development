import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  void playSound(String sound) {
    final player = AudioCache();
    player.play(sound);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Xylophone")),
          backgroundColor: Colors.red,
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  playSound('note1.wav');
                },
                child: Text(''),
              ),
            ),

            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  playSound('note2.wav');
                },
                child: Text(''),
              ),
            ),

            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  playSound('note3.wav');
                },
                child: Text(''),
              ),
            ),

            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  playSound('note4.wav');
                },
                child: Text(''),
              ),
            ),

            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  playSound('note5.wav');
                },
                child: Text(''),
              ),
            ),

            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  playSound('note6.wav');
                },
                child: Text(''),
              ),
            ),

            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () {
                  playSound('note7.wav');
                },
                child: Text(''),
              ),
            ),

          ],
        ),
      ),
    );
  }
}