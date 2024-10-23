import 'package:flutter/material.dart';
import 'package:pcs_6/model/note.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<Note> cartItems;

  const ShoppingCartPage({super.key, required this.cartItems});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  void _removeFromCart(Note note) {
    setState(() {
      widget.cartItems.remove(note);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${note.title} удален из корзины!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        // Removed the delete all items button
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Ваша корзина пуста!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final note = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(note.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(note.title),
                    subtitle: Text('Цена: ${note.price} рублей'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_shopping_cart),
                      onPressed: () {
                        _removeFromCart(note); 
                      },
                    ),
                  ),
                );
              },
            ),    
    );
  }

  void _checkout() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Ваша корзина пуста!'),
      ));
      return;
    }
  }
}
