import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_card.dart';
import 'item_detail_screen.dart';
import 'add_item_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import '../widgets/bottom_navigation_bar.dart';

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
      description: 'Balenciaga 3XL Extreme Lace — это воплощение дерзкого и экстравагантного стиля.',
    ),
    Item(
      id: '2',
      name: 'New Rock M-120N-S24 White',
      brand: 'New Rock',
      imagePath: 'assets/images/nr.jpg',
      price: 300.0,
      description: 'New Rock M-120N-S24 White — это сочетание дерзости и брутального стиля.',
    ),
    Item(
      id: '3',
      name: 'Rick Owens x Dr Martens 1460',
      brand: 'Rick Owens x Dr Martens',
      imagePath: 'assets/images/1460.jpg',
      price: 500.0,
      description: 'Rick Owens Dr. Martens 1460 Pentagram Boots — это смелая интерпретация классики.',
    ),
    Item(
      id: '4',
      name: 'Rick Owens Drkshdw Ramones',
      brand: 'Rick Owens',
      imagePath: 'assets/images/ramones.jpg',
      price: 350.0,
      description: 'Rick Owens DRKSHDW Ramones — это сочетание панк-эстетики и высокой моды.',
    ),
  ];

  final List<Item> favorites = [];
  int _currentIndex = 0;

  void _toggleFavorite(Item item) {
    setState(() {
      if (favorites.contains(item)) {
        favorites.remove(item);
      } else {
        favorites.add(item);
      }
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _deleteItem(Item item) {
    setState(() {
      items.remove(item); // Удаление товара
      favorites.remove(item); // Удаление из избранного, если он там есть
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    switch (_currentIndex) {
      case 0:
        currentScreen = Scaffold(
          appBar: AppBar(
            title: const Text('FullienWear'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemScreen(onAddItem: (item) {
                        setState(() {
                          items.add(item);
                        });
                      }),
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
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75,
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
                        isFavorite: favorites.contains(items[index]),
                        onDelete: () {
                          _deleteItem(items[index]);
                          Navigator.of(context).pop();
                        },
                        onFavoriteToggle: () {
                          _toggleFavorite(items[index]);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
        break;
      case 1:
        currentScreen = FavoritesScreen(
          favorites: favorites,
          onFavoriteToggle: _toggleFavorite,
        );
        break;
      case 2:
        currentScreen = ProfileScreen();
        break;
      default:
        currentScreen = Container(); // Пустой контейнер для защиты от ошибок
    }

    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}