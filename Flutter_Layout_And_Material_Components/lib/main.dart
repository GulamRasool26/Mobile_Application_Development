import "package:flutter/material.dart";

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
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
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.purple,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              // margin: EdgeInsets.only(left:10),
            child: Text("Container"),
            ),
            Card(
              child:Column(
                children: [
                const ListTile(
                  minLeadingWidth: 50,
                  minTileHeight: 50,
                  
                  leading: Icon(Icons.account_circle),
                  title: Text("Card 1"),
                  tileColor: Colors.red,
                )  
                ],
              )   
              ),
            
            Card(
             child:Column(
                children: [
                const ListTile(
                  minLeadingWidth: 100,
                  minTileHeight: 100,
                  
                  leading: Icon(Icons.face_2_outlined),
                  title: Text("Card 2"),
                  tileColor: Colors.blue,
                )
                  
                ],
              ) 
            ),
            Card(
              child:Column(
                children: [
                const ListTile(
                  minLeadingWidth: 150,
                  minTileHeight: 150,
                  leading: Icon(Icons.cable_outlined),
                  title: Text("Card 3"),
                  tileColor: Colors.green,
                )
                  
                ],
              ) 
            ),
          ],
        ),
        )
    );
  }
}
