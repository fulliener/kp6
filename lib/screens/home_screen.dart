import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_card.dart';
import 'item_detail_screen.dart';
import 'add_item_screen.dart';

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
      name: 'Кроссовки Balenciaga 3XL Extreme Lace',
      brand: 'Balenciaga',
      imagePath: 'assets/images/3xl.jpg',
      price: 1000.0,
      description: 'Balenciaga 3XL Extreme Lace — это воплощение дерзкого и экстравагантного стиля. Верх пары выполнен из комбинации сетчатого текстиля и синтетической кожи, что обеспечивает прочность и дышащие свойства. Массивный силуэт вдохновлен актуальной тенденцией на «тяжелые» кроссовки. Толстая межподошва из EVA гарантирует комфорт и амортизацию при каждом шаге, а подметка с выраженным протектором обеспечивает сцепление с любой поверхностью. Шнуровка в несколько слоев добавляет уникальный акцент, подчеркивая стильный и современный образ. Эти кроссовки — идеальное решение для тех, кто ценит смелые решения в моде.',
    ),
    Item(
      id: '2',
      name: 'Ботинки New Rock M-120N-S24 White',
      brand: 'New Rock',
      imagePath: 'assets/images/nr.jpg',
      price: 300.0,
      description: 'New Rock M-120N-S24 White — это сочетание дерзости и брутального стиля. Верх пары изготовлен из высококачественной натуральной кожи, обеспечивающей долговечность и комфорт. Массивная подошва с металлическими элементами и усиленной пяткой придает модели узнаваемый готический вид. Специальная система шнуровки и боковые застежки создают уверенную фиксацию стопы, обеспечивая удобство при носке. Прочная резиновая подметка гарантирует отличное сцепление с поверхностью. Эта пара идеально подходит для тех, кто предпочитает выражать свою индивидуальность через уникальный и неординарный стиль.',
    ),
    Item(
      id: '3',
      name: 'Ботинки Rick Owens x Dr Martens 1460',
      brand: 'Rick Owens x Dr Martens',
      imagePath: 'assets/images/1460.jpg',
      price: 500.0,
      description: 'Rick Owens Dr. Martens 1460 Pentagram Boots — это смелая интерпретация классических ботинок с элементами авангардного дизайна. Верх выполнен из гладкой кожи премиум-класса, отличающейся долговечностью и эстетикой. Узнаваемая шнуровка в форме пентаграммы и серебряные кольца придают паре уникальный характер. Модель основана на культовом силуэте 1460 от Dr. Martens с прочной, маслостойкой резиновой подошвой, которая обеспечивает отличное сцепление и комфорт при ходьбе. Традиционные фирменные акценты, такие как прошитый рант и воздушная амортизация AirWair, добавляют этой коллаборации удобство и стиль.',
    ),
    Item(
      id: '4',
      name: 'Кеды Rick Owens Drkshdw Ramones',
      brand: 'Rick Owens',
      imagePath: 'assets/images/ramones.jpg',
      price: 350.0,
      description: 'Rick Owens DRKSHDW Ramones — это сочетание панк-эстетики и высокой моды в культовом исполнении. Верх модели выполнен из прочного текстиля или премиальной кожи, что подчеркивает утонченный и минималистичный стиль. Широкая резиновая подошва с закругленным носком, вдохновленная классическими кедами, обеспечивает комфорт и долговечность. Преувеличенные пропорции и высокая шнуровка добавляют модели характерный дерзкий вид. Застежка-молния сбоку упрощает надевание, сохраняя при этом уникальный силуэт. Эти кеды идеально подходят для тех, кто ценит уникальный стиль и высокое качество в повседневной одежде.',
    ),
  ];

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
        items.remove(item);  // Удаление товара
      });
    }
  }

  // Метод для добавления нового товара
  void _addItem(Item item) {
    setState(() {
      items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FullienWear'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeChange,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemCard(
            item: items[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(item: items[index]),
                ),
              );
            },
            onDelete: () => _deleteItem(context, items[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(onAddItem: _addItem),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
