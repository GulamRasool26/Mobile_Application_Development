import 'package:flutter/material.dart';

void main() {
  runApp(MyFlutterApp());
}

class MyFlutterApp extends StatelessWidget 
{
  @override
  Widget build (BuildContext context)
  {
    return MaterialApp
    (
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text("Flutter Lab - 1"),
      ),
      body:Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(" Row-1 (Item 1) "),
              SizedBox(width: 20),
              Text(" Row-2 (Item 2) "),
            ],
          ),
          
          Text("Asset- Image"),
          SizedBox(height: 10),
          Image.asset("assets/images/image.jpg"),
          Text("Network- Image"),
          SizedBox(height: 10),
          Image.network("https://picsum.photos/id/4/367/267"),
        ],
      )
    );
  }
}
