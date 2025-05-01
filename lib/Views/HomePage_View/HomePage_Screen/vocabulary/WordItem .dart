// widgets/word_item.dart
import 'package:flutter/material.dart';
import '../../../../Models/WordModel.dart';
import '../../../../Widgets/_showActionMenu.dart';

class WordItem extends StatelessWidget {
  final WordModel word;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onPronunciation;

  const WordItem(
      this.word, {
        super.key,
        this.onDelete,
        this.onEdit,
        this.onPronunciation,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 6,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          word.term,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word.meaning),
            if (word.example != null && word.example!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Example: ${word.example!}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.volume_up, color: Colors.orangeAccent[100]),
              onPressed: onPronunciation,
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                if (onEdit != null && onDelete != null) {
                  showWordActionsMenu(
                    context: context,
                    onEdit: onEdit!,
                    onDelete: onDelete!,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}