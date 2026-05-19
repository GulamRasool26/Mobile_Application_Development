import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';
import '../services/firestore_service.dart';
import '../widgets/task_card.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final User? _user = FirebaseAuth.instance.currentUser;

  void _showTaskDialog({TaskModel? task}) {
    final titleController = TextEditingController(text: task?.title ?? '');
    final descController = TextEditingController(text: task?.description ?? '');
    DateTime selectedDate = task?.dueDate ?? DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task == null ? 'Add Task' : 'Edit Task', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 8),
                      Text("Due: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setStateModal(() => selectedDate = picked);
                          }
                        },
                        child: const Text('Select Date'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isEmpty) return;
                        if (task == null) {
                          _firestoreService.addTask(
                            TaskModel(
                              id: '',
                              title: titleController.text,
                              description: descController.text,
                              dueDate: selectedDate,
                              isCompleted: false,
                              userId: _user!.uid,
                            ),
                          );
                        } else {
                          task.title = titleController.text;
                          task.description = descController.text;
                          task.dueDate = selectedDate;
                          _firestoreService.updateTask(task);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(task == null ? 'Add Task' : 'Update Task'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) return const Center(child: Text("Not logged in"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: _firestoreService.getTasks(_user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found. Add one!'));
          }
          
          final tasks = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskCard(
                task: task,
                onToggle: () => _firestoreService.toggleTaskCompletion(task.id, task.isCompleted),
                onDelete: () => _firestoreService.deleteTask(task.id),
                onEdit: () => _showTaskDialog(task: task),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
