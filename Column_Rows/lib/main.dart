import "package:flutter/material.dart";

void main()
{
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: "Flutter App",
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
      
        
      body:SafeArea(
        child:Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue,
              height: 100,
              width: double.infinity,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Container
                ( 
                  height: 60,
                  width: 60,
                  color:Colors.red,
                  
                ),
                Container
                (
                  height: 60,
                  width: 60,
                  color:Colors.green,
                  
                ),
              ]
            ),
                    ]
      ),
      ),
      );
  }
}