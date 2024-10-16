import 'package:flutter/material.dart';
import 'package:pcs_6/model/note.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  final Function(Note) onDelete;
  final bool isFavorite;
  final Function(Note) onFavoriteToggle;

  const ItemNote({
    super.key,
    required this.note,
    required this.onDelete,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center( 
              child: Text(
                note.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center, 
              ),
            ),
          ),
          Expanded(child: Center(child: Image.asset(note.imageUrl, fit: BoxFit.cover))),
          const SizedBox(height: 4),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '- Цена: ${note.price} рублей',
              style: const TextStyle(fontSize: 16, color: Colors.black), 
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              note.textNote,
              style: const TextStyle(fontSize: 16, color: Colors.black), 
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                onFavoriteToggle(note); 
              },
            ),
          ),
        ],
      ),
    );
  }
}
