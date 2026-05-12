import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Route")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // HERO IMAGE
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HeroScreen()),
              );
            },
            child: Hero(
              tag: "heroImage",
              child: Image.network(
                "https://picsum.photos/200",
                height: 150,
             
              ),
            ),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            child: Text("Go Back"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class HeroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Screen")),
      body: Center(
        child: Hero(
          tag: "heroImage",
          child: Image.network("https://picsum.photos/400"),
        ),
      ),
    );
  }
}

