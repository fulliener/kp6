import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_card.dart';
import 'item_detail_screen.dart';
import 'add_item_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChange;

  HomeScreen({Key? key, required this.onThemeChange}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> items = [
    Item(
      id: '1',
      name: 'Balenciaga 3XL Extreme Lace',
      brand: 'Balenciaga',
      imagePath: 'assets/images/3xl.jpg',
      price: 1000.0,
      description:
      'Balenciaga 3XL Extreme Lace — это воплощение дерзкого и экстравагантного стиля.',
    ),
    Item(
      id: '2',
      name: 'New Rock M-120N-S24 White',
      brand: 'New Rock',
      imagePath: 'assets/images/nr.jpg',
      price: 300.0,
      description:
      'New Rock M-120N-S24 White — это сочетание дерзости и брутального стиля.',
    ),
    Item(
      id: '3',
      name: 'Rick Owens x Dr Martens 1460',
      brand: 'Rick Owens x Dr Martens',
      imagePath: 'assets/images/1460.jpg',
      price: 500.0,
      description:
      'Rick Owens Dr. Martens 1460 Pentagram Boots — это смелая интерпретация классики.',
    ),
    Item(
      id: '4',
      name: 'Rick Owens Drkshdw Ramones',
      brand: 'Rick Owens',
      imagePath: 'assets/images/ramones.jpg',
      price: 350.0,
      description:
      'Rick Owens DRKSHDW Ramones — это сочетание панк-эстетики и высокой моды.',
    ),
  ];

  // Хранение избранных товаров
  final List<Item> favorites = [];

  // Удаление товара с подтверждением
  void _deleteItem(BuildContext context, Item item) async {
    final bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить товар?'),
        content: Text('Вы уверены, что хотите удалить "${item.name}"?'),
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
      setState(() {
        items.remove(item); // Удаление товара
      });
    }
  }

  // Метод для добавления нового товара
  void _addItem(Item item) {
    setState(() {
      items.add(item);
    });
  }

  // Метод для добавления/удаления товара в/из избранных
  void _toggleFavorite(Item item) {
    setState(() {
      if (favorites.contains(item)) {
        favorites.remove(item); // Удаляем из избранного
      } else {
        favorites.add(item); // Добавляем в избранное
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FullienWear'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add), // Кнопка добавления товара
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItemScreen(onAddItem: _addItem),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeChange,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Количество колонок
          crossAxisSpacing: 8.0, // Промежутки между колонками
          mainAxisSpacing: 8.0, // Промежутки между строками
          childAspectRatio: 0.75, // Соотношение ширины и высоты элементов
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemCard(
            item: items[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(
                      item: items[index],
                      onDelete: () {
                        _deleteItem(context, items[index]);
                      },
                      isFavorite: favorites.contains(items[index]), // Убедись, что этот параметр передан
                      onFavoriteToggle: () {
                        _toggleFavorite(items[index]);
                        setState(() {});
                      }
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritesScreen(
                  favorites: favorites, // Передаем список избранных
                  onFavoriteToggle: _toggleFavorite, // Передаем функцию для изменения избранного
                ),
              ),
            );
          } else if (index == 2) {
            // Исправлено: теперь открывается ProfileScreen вместо FavoritesScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(), // Открываем экран профиля
              ),
            );
          }
        },
      ),
    );
  }
}