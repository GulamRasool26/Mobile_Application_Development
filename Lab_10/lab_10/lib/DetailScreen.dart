import 'package:flutter/material.dart';
import 'TodoModel.dart';

class DetailScreen extends StatelessWidget {
  final Todo todo;

  DetailScreen({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}