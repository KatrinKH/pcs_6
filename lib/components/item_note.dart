import 'package:flutter/material.dart';
import 'package:pcs_6/model/note.dart';

class ItemNote extends StatefulWidget {
  final Note note;
  final Function(Note) onDelete;
  final bool isFavorite;
  final Function(Note) onFavoriteToggle;
  final Function(Note, bool) onAddToCart; 
  final bool isInCart;

  const ItemNote({
    super.key,
    required this.note,
    required this.onDelete,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.isInCart,
  });

  @override
  _ItemNoteState createState() => _ItemNoteState();
}

class _ItemNoteState extends State<ItemNote> {
  late bool _isInCart;

  @override
  void initState() {
    super.initState();
    _isInCart = widget.isInCart; 
  }

  void _toggleCart() {
    setState(() {
      _isInCart = !_isInCart; 
    });
    widget.onAddToCart(widget.note, _isInCart); 
  }

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
                widget.note.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(widget.note.imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '- Цена: ${widget.note.price} рублей',
              style: const TextStyle(fontSize: 16, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.note.textNote,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_shopping_cart_sharp,
                  color: _isInCart ? Colors.green : Colors.black, 
                ),
                onPressed: _toggleCart, 
              ),
              IconButton(
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  widget.onFavoriteToggle(widget.note);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
