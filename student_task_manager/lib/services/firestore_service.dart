import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import '../models/note_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Tasks Collection
  CollectionReference get _tasksRef => _db.collection('tasks');

  // Notes Collection
  CollectionReference get _notesRef => _db.collection('notes');

  // Add Task
  Future<void> addTask(TaskModel task) async {
    await _tasksRef.add(task.toMap());
  }

  // Update Task
  Future<void> updateTask(TaskModel task) async {
    await _tasksRef.doc(task.id).update(task.toMap());
  }

  // Delete Task
  Future<void> deleteTask(String id) async {
    await _tasksRef.doc(id).delete();
  }

  // Toggle Task Completion
  Future<void> toggleTaskCompletion(String id, bool currentStatus) async {
    await _tasksRef.doc(id).update({'isCompleted': !currentStatus});
  }

  // Get Tasks Stream for User
  Stream<List<TaskModel>> getTasks(String userId) {
    return _tasksRef
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final tasks = snapshot.docs
              .map((doc) => TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
              .toList();
          tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
          return tasks;
        });
  }

  // Add Note
  Future<void> addNote(NoteModel note) async {
    await _notesRef.add(note.toMap());
  }

  // Update Note
  Future<void> updateNote(NoteModel note) async {
    await _notesRef.doc(note.id).update(note.toMap());
  }

  // Delete Note
  Future<void> deleteNote(String id) async {
    await _notesRef.doc(id).delete();
  }

  // Get Notes Stream for User
  Stream<List<NoteModel>> getNotes(String userId) {
    return _notesRef
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final notes = snapshot.docs
              .map((doc) => NoteModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
              .toList();
          notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return notes;
        });
  }
}
