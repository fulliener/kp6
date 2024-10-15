import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item;
  final VoidCallback onDelete;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;

  const ItemDetailScreen({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.item.imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.item.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.item.brand} | \$${widget.item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.item.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(), // Заполняет оставшееся пространство
                // Кнопка "Добавить в корзину" по центру
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onAddToCart(); // Вызов функции добавления в корзину
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${widget.item.name} добавлен в корзину!')),
                      );
                    },
                    child: const Text('Добавить в корзину'),
                  ),
                ),
                const SizedBox(height: 16), // Добавляем немного отступа снизу
              ],
            ),
          ),
          // Кнопка удаления в верхнем левом углу
          Positioned(
            left: 10,
            top: 10,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: () async {
                final bool confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Удалить товар?'),
                    content: Text('Вы уверены, что хотите удалить "${widget.item.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Нет'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Да'),
                      ),
                    ],
                  ),
                );
                if (confirm) {
                  widget.onDelete();  // Удаляем элемент
                }
              },
            ),
          ),
          // Кнопка лайка в верхнем правом углу
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                widget.onFavoriteToggle();
              },
            ),
          ),
        ],
      ),
    );
  }
}
