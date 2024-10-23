import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  void _confirmRemoval(Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Подтверждение удаления'),
          content: Text('Вы уверены, что хотите удалить "${note.title}" из корзины?'),
          actions: [
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text('Удалить'),
              onPressed: () {
                _removeFromCart(note);
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }

  double _calculateTotal() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      total += item.price * item.quantity; 
    }
    return total;
  }

  void _incrementQuantity(Note note) {
    setState(() {
      note.quantity++;
    });
  }

  void _decrementQuantity(Note note) {
    setState(() {
      if (note.quantity > 1) {
        note.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Ваша корзина пуста!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final note = widget.cartItems[index];
                      return Slidable(
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: Image.asset(note.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(note.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Цена: ${note.price} рублей'),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () => _decrementQuantity(note),
                                    ),
                                    Text('${note.quantity}'), // Display quantity
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => _incrementQuantity(note),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => _confirmRemoval(note),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Удалить',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: const Color(0xFF67BEEA), 
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Общая сумма:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Flexible(
                            child: Text(
                              '${_calculateTotal().toStringAsFixed(2)} рублей',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              overflow: TextOverflow.ellipsis, 
                              maxLines: 1, 
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), 
                    ],
                  ),
                ),
                const SizedBox(height: 10), 
              ],
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
