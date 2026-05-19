import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';
import '../services/firestore_service.dart';
import '../widgets/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final User? _user = FirebaseAuth.instance.currentUser;

  void _showNoteDialog({NoteModel? note}) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
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
              Text(note == null ? 'Add Note' : 'Edit Note', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content', border: OutlineInputBorder()),
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty && contentController.text.isEmpty) return;
                    if (note == null) {
                      _firestoreService.addNote(
                        NoteModel(
                          id: '',
                          title: titleController.text.isEmpty ? 'Untitled' : titleController.text,
                          content: contentController.text,
                          createdAt: DateTime.now(),
                          userId: _user!.uid,
                        ),
                      );
                    } else {
                      note.title = titleController.text;
                      note.content = contentController.text;
                      _firestoreService.updateNote(note);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(note == null ? 'Save Note' : 'Update Note'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) return const Center(child: Text("Not logged in"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: _firestoreService.getNotes(_user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes found. Create one!'));
          }
          
          final notes = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteCard(
                note: note,
                onDelete: () => _firestoreService.deleteNote(note.id),
                onEdit: () => _showNoteDialog(note: note),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
