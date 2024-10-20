import 'package:flutter/material.dart';
import 'package:pcs_6/model/note.dart';
import 'package:pcs_6/pages/favorites_page.dart';
import 'package:pcs_6/pages/home_page.dart';
import 'package:pcs_6/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo 米可-06',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 126, 96, 178)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Note> _favoriteNotes = []; 
  List<Note> _cart = []; 

  void _toggleFavorite(Note note) {
    setState(() {
      if (_favoriteNotes.contains(note)) {
        _favoriteNotes.remove(note);
      } else {
        _favoriteNotes.add(note);
      }
    });
  }

  void _removeFromFavorites(Note note) {
    setState(() {
      _favoriteNotes.remove(note);
    });
  }

  bool _isFavorite(Note note) {
    return _favoriteNotes.contains(note);
  }

  void _addToCart(Note note) {
    setState(() {
      _cart.add(note);
    });
  }

  void _removeFromCart(Note note) {
    setState(() {
      _cart.remove(note);
    });
  }

  bool _isCartEmpty() {
    return _cart.isEmpty;
  }

  List<Widget> _widgetOptions() {
    return [
      HomePage(
        favoriteNotes: _favoriteNotes,
        onFavoriteToggle: _toggleFavorite,
        isFavorite: _isFavorite,
      ),
      FavoritesPage(
        favoriteNotes: _favoriteNotes,
        onRemoveFromFavorites: _removeFromFavorites,
      ),
      const ProfilePage()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions().elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 32, 100, 156),
        onTap: _onItemTapped,
      ),
    );
  }
}
