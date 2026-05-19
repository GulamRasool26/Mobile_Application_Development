import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  note.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM d').format(note.createdAt),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  InkWell(
                    onTap: onDelete,
                    child: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
