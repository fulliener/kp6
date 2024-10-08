import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item;
  final VoidCallback onDelete;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ItemDetailScreen({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late bool isFavorite; // Изменяем на late, чтобы инициализировать в initState

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite; // Устанавливаем начальное состояние isFavorite
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
                  widget.onDelete();  // Вызов удаления
                  Navigator.pop(context);  // Возврат на предыдущий экран после удаления
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
                  isFavorite = !isFavorite; // Обновляем локальное состояние
                });
                widget.onFavoriteToggle(); // Сообщаем HomeScreen об изменении избранного
              },
            ),
          ),
        ],
      ),
    );
  }
}
