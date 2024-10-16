import 'package:flutter/material.dart';
import 'package:pcs_6/components/item_note.dart';
import 'package:pcs_6/model/note.dart';
import 'package:pcs_6/pages/add_note_page.dart';
import 'package:pcs_6/pages/note_page.dart';

class HomePage extends StatefulWidget {
  final List<Note> favoriteNotes; 
  final Function(Note) onFavoriteToggle; 
  final bool Function(Note) isFavorite; 

  const HomePage({
    super.key,
    required this.favoriteNotes,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = List.from(notes); 

  void deleteNote(Note note) {
    setState(() {
      _notes.remove(note);
    });
  }

  void addNote(Note newNote) {
    setState(() {
      _notes.add(newNote);
    });
  }

  void _navigateToAddNotePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNotePage(
          onNoteAdded: (newNote) {
            addNote(newNote);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Видеоигры')),
      ),
      backgroundColor: const Color(0xFF67BEEA),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.5, 
          crossAxisSpacing: 16.0, 
          mainAxisSpacing: 16.0,  
        ),
        padding: const EdgeInsets.all(16.0), 
        itemCount: _notes.length,
        itemBuilder: (BuildContext context, int index) {
          Note note = _notes[index];
          bool isFavorite = widget.isFavorite(note); 

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(note: note, onDelete: deleteNote),
                ),
              );
            },
            child: ItemNote(
              note: note,
              onDelete: deleteNote,
              isFavorite: isFavorite,
              onFavoriteToggle: widget.onFavoriteToggle,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNotePage,
        backgroundColor: const Color.fromARGB(255, 78, 255, 65),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
