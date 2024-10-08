import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_card.dart'; // Используем ItemCard для отображения как в каталоге
import 'item_detail_screen.dart';
import 'profile_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Item> favorites;
  final Function(Item) onFavoriteToggle;

  const FavoritesScreen({
    Key? key,
    required this.favorites,
    required this.onFavoriteToggle, // Передаем функцию для изменения избранного
  }) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: widget.favorites.isEmpty
          ? const Center(
        child: Text('Избранных товаров нет.'),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Отображаем товары сеткой (по 2 в ряд)
          crossAxisSpacing: 8.0, // Промежутки между колонками
          mainAxisSpacing: 8.0, // Промежутки между строками
          childAspectRatio: 0.75, // Соотношение ширины и высоты элементов
        ),
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final item = widget.favorites[index];

          return ItemCard(
            item: item,
            onTap: () async {
              // Переход на экран деталей с ожиданием возврата
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(
                    item: item,
                    isFavorite: true, // Убедимся, что товар отображается как избранный
                    onFavoriteToggle: () {
                      widget.onFavoriteToggle(item);
                    },
                    onDelete: () {},
                  ),
                ),
              );

              // Обновляем экран избранного после возврата
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
