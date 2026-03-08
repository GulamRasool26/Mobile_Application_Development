import 'package:flutter/material.dart';
void main()
{
  runApp(const FlutterApp());
}
class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Profile(),
    );
  }
}
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                child:CircleAvatar(
                  radius:50,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                ),
              ),
              Text("Gulam Rasool",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Text("23-NTU-CS-FL-1159",style: TextStyle(fontSize: 18,color: Colors.grey),),
             SizedBox(height:30),
              Row(
                children:[
                  Expanded(
                    flex:2,
                    child:Container(
                          height:120,
                          color: Colors.blue,
                          child:Center(
                            child:Text("Posts",style: TextStyle(color: Colors.white))
                                      ),
                                    ),
                          ),
                  Expanded(
                    flex:1,
                    child:Container(
                          height:120,
                          color: Colors.green,
                          child:Center(
                            child:Text("Followers",style: TextStyle(color: Colors.white))
                                      ),
                                  ),
                          ),
                        ]
                )
            ],
        ),
        ),
    );
  }
}