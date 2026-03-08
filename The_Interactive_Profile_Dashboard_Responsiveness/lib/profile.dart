import"package:flutter/material.dart";

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Profile(),
    );
  }
}
class Profile extends StatefulWidget
{
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();

}

class _ProfileState extends State<Profile>
{
  bool isFollowed = false;
  int score = 0;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child:Column(
          children: [
            Text("Profile Dashboard -1159",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                setState(() {
                  isFollowed = !isFollowed;
                  });
              },
              child: Text(isFollowed ? "Following" : "Follow"),
            ),
            SizedBox(height: 20),

            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: (){
                setState(() {
                  score++;
                });
              },
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              margin : EdgeInsets.all(20),
              child:ListTile
              (
                leading: Icon(Icons.star, color:Colors.orange),
                title: Text("Likes"),
                subtitle: Text("Total Likes: $score"),
              )
            )
          ],
          ),
          ),
    );
  }
}