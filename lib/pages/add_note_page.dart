import 'package:flutter/material.dart';
import 'package:pcs_6/model/note.dart';

class AddNotePage extends StatefulWidget {
  final Function(Note) onNoteAdded;

  const AddNotePage({Key? key, required this.onNoteAdded}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textNoteController = TextEditingController();
  final TextEditingController textMainController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController developerController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новую игру'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: textNoteController,
              decoration: const InputDecoration(labelText: 'Краткое описание'),
            ),
            TextField(
              controller: textMainController,
              decoration: const InputDecoration(labelText: 'Основная информация об игре'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'URL изображения'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: genreController,
              decoration: const InputDecoration(labelText: 'Жанр игры'),
            ),
            TextField(
              controller: developerController,
              decoration: const InputDecoration(labelText: 'Разработчик'),
            ),
            TextField(
              controller: releaseDateController,
              decoration: const InputDecoration(labelText: 'Дата выпуска'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text.trim();
                String textNote = textNoteController.text.trim();
                String textMain = textMainController.text.trim();
                String imageUrl = imageUrlController.text.trim();
                String genre = genreController.text.trim();
                String developer = developerController.text.trim();
                String releaseDate = releaseDateController.text.trim();

                if (title.isEmpty || textNote.isEmpty || textMain.isEmpty || genre.isEmpty || developer.isEmpty || releaseDate.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Ошибка'),
                        content: const Text('Пожалуйста, заполните все обязательные поля.'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                double price = double.tryParse(priceController.text) ?? 0.0;
                Note newNote = Note(
                  id: DateTime.now().millisecondsSinceEpoch, 
                  title: title,
                  textNote: textNote,
                  textMain: textMain,
                  imageUrl: imageUrl,
                  price: price,
                  genre: genre,
                  developer: developer,
                  releaseDate: releaseDate,
                );
                widget.onNoteAdded(newNote);
                Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}