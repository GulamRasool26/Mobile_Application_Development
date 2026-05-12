import 'package:flutter/material.dart';
import 'TodoModel.dart';
import 'DetailScreen.dart';

class TodosScreen extends StatelessWidget {
  final List<Todo> todos = List.generate(
    10,
    (i) => Todo("Todo $i", "Description of Todo $i"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todos")),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}