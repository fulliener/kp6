import 'package:flutter/material.dart';
import '../models/item.dart';
import 'item_detail_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Item> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Храним количество товаров для каждого элемента
  final Map<Item, int> itemQuantities = {};

  @override
  void initState() {
    super.initState();
    // Инициализируем количество для каждого товара как 1
    widget.cartItems.forEach((item) {
      itemQuantities[item] = 1;
    });
  }

  void _increaseQuantity(Item item) {
    setState(() {
      itemQuantities[item] = (itemQuantities[item]! + 1);
    });
  }

  void _decreaseQuantity(Item item) {
    final currentQuantity = itemQuantities[item]!;

    if (currentQuantity > 1) {
      setState(() {
        itemQuantities[item] = currentQuantity - 1;
      });
    } else {
      // Показываем диалог для подтверждения удаления товара
      _showDeleteConfirmationDialog(item);
    }
  }

  void _showDeleteConfirmationDialog(Item item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить товар из корзины?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
              child: const Text('Нет'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.cartItems.remove(item); // Удаляем товар из корзины
                  itemQuantities.remove(item);    // Убираем из Map
                });
                Navigator.of(context).pop(); // Закрыть диалог
              },
              child: const Text('Да'),
            ),
          ],
        );
      },
    );
  }

  void _removeItem(Item item) {
    setState(() {
      widget.cartItems.remove(item); // Удаляем товар из корзины
      itemQuantities.remove(item);    // Убираем из Map
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
        child: Text('Корзина пуста'),
      )
          : ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final item = widget.cartItems[index];
          final quantity = itemQuantities[item] ?? 1; // Количество товара

          return Dismissible(
            key: Key(item.name), // Уникальный ключ для каждого элемента
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              // Показываем диалог для подтверждения удаления
              return await _showDismissConfirmationDialog(item);
            },
            onDismissed: (direction) {
              _removeItem(item);
              // Выводим сообщение об удалении
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} удалён из корзины')),
              );
            },
            child: ListTile(
              leading: Image.asset(item.imagePath, width: 50, height: 50),
              title: Text(item.name),
              subtitle: Text('Цена: \$${(item.price * quantity).toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      _decreaseQuantity(item);
                    },
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _increaseQuantity(item);
                    },
                  ),
                ],
              ),
              onTap: () {
                // Переход на экран с деталями товара при клике на элемент
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailScreen(
                      item: item,
                      isFavorite: false, // Задай true, если нужно отобразить как избранное
                      onFavoriteToggle: () {},
                      onDelete: () {},
                      onAddToCart: () {
                        // Логика для добавления в корзину, если нужно
                        setState(() {
                          widget.cartItems.add(item); // Добавляем товар в корзину
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<bool?> _showDismissConfirmationDialog(Item item) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить товар из корзины?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Закрыть диалог с ответом 'Нет'
              },
              child: const Text('Нет'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Закрыть диалог с ответом 'Да'
              },
              child: const Text('Да'),
            ),
          ],
        );
      },
    );
  }
}
