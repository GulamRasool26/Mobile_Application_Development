import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/api_service.dart';
import '../services/firestore_service.dart';
import '../models/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final FirestoreService _firestoreService = FirestoreService();
  final User? _user = FirebaseAuth.instance.currentUser;
  
  Map<String, String>? _quote;
  bool _isLoadingQuote = true;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    setState(() => _isLoadingQuote = true);
    final quote = await _apiService.fetchDailyQuote();
    if (mounted) {
      setState(() {
        _quote = quote;
        _isLoadingQuote = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: _user == null 
          ? const Center(child: Text("Not logged in"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    _user.email ?? 'Student',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Quote Card
                  Card(
                    elevation: 4,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.format_quote, size: 30),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: _fetchQuote,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _isLoadingQuote
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '"${_quote?['content'] ?? ''}"',
                                      style: const TextStyle(
                                          fontSize: 16, fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '- ${_quote?['author'] ?? ''}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Task Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // Task Stats
                  StreamBuilder<List<TaskModel>>(
                    stream: _firestoreService.getTasks(_user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      final tasks = snapshot.data ?? [];
                      final totalTasks = tasks.length;
                      final completedTasks = tasks.where((t) => t.isCompleted).length;
                      final pendingTasks = totalTasks - completedTasks;
                      
                      return Row(
                        children: [
                          Expanded(child: _buildStatCard('Total', totalTasks.toString(), Colors.blue)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildStatCard('Completed', completedTasks.toString(), Colors.green)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildStatCard('Pending', pendingTasks.toString(), Colors.orange)),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
