import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_card.dart';
import 'item_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Item> favorites;
  final Function(Item) onFavoriteToggle;

  const FavoritesScreen({
    Key? key,
    required this.favorites,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'), // Заголовок для экрана избранного
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text('Избранных товаров нет.'),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];

          return ItemCard(
            item: item,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(
                    item: item,
                    isFavorite: true,
                    onFavoriteToggle: () {
                      onFavoriteToggle(item);
                    },
                    onDelete: () {},
                  ),
                ),
              );

              // Обновляем экран избранного после возврата
              // В данном случае, он будет автоматически обновлен
            },
          );
        },
      ),
    );
  }
}
