import 'package:flutter/material.dart';
import 'package:pcs_6/model/note.dart';
import 'package:pcs_6/pages/note_page.dart';

class FavoritesPage extends StatelessWidget {
  final List<Note> favoriteNotes;
  final Function(Note) onRemoveFromFavorites; 

  const FavoritesPage({
    super.key,
    required this.favoriteNotes,
    required this.onRemoveFromFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Избранное')),
      ),
      backgroundColor: const Color(0xFF67BEEA), 
      body: favoriteNotes.isEmpty
          ? const Center(child: Text('Нет избранных игр'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.5, 
                crossAxisSpacing: 16.0, 
                mainAxisSpacing: 16.0,  
              ),
              padding: const EdgeInsets.all(16.0), 
              itemCount: favoriteNotes.length,
              itemBuilder: (context, index) {
                final note = favoriteNotes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotePage(note: note, onDelete: (Note note) {}),
                      ),
                    );
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(
                              note.title,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis))),

                        Expanded(child: Center(child: Image.asset(note.imageUrl, fit: BoxFit.cover))),
                        const SizedBox(height: 4),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('- Цена: ${note.price} рублей',
                            style: const TextStyle(fontSize: 16, color: Colors.black), 
                            overflow: TextOverflow.ellipsis)),
                        const SizedBox(height: 4),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(note.textNote,
                            style: const TextStyle(fontSize: 16, color: Colors.black), 
                            overflow: TextOverflow.ellipsis)),
                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              onRemoveFromFavorites(note);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
