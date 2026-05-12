import 'package:flutter/material.dart';
import 'Seconde_Screen.dart';
import 'todosScreen.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Route")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              child: Text("Go to Second Route"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Go to Todo List"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodosScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}