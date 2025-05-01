import 'package:flutter/material.dart';

void showWordPopupMenu({
  required BuildContext context,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
}) {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(button.size.topRight(Offset.zero)),
      button.localToGlobal(button.size.bottomRight(Offset.zero)),
    ),
    Offset.zero & overlay.size,
  );

  showMenu(
    color: Colors.white,
    context: context,
    position: position,
    items: [
      PopupMenuItem(
        child: Row(
          children: [
            Icon(Icons.edit, color: Colors.orangeAccent[100]),
            SizedBox(width: 8),
            Text('Edit'),
          ],
        ),
        onTap: () {
          onEdit();
        },
      ),
      PopupMenuItem(
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete'),
          ],
        ),
        onTap: () {
          onDelete();
        },
      ),
    ],
  );
}