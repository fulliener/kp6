import 'package:flutter/material.dart';
import '../models/item.dart';

class AddItemScreen extends StatefulWidget {
  final Function(Item) onAddItem;

  AddItemScreen({required this.onAddItem});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String brand = '';
  String imagePath = '';
  double price = 0.0;
  String description = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onAddItem(Item(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Генерация ID
        name: name,
        brand: brand,
        imagePath: imagePath,
        price: price,
        description: description,
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название';
                  }
                  return null;
                },
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Бренд'),
                onChanged: (value) => brand = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = double.parse(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Описание'),
                onChanged: (value) => description = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Путь к изображению'),
                onChanged: (value) => imagePath = value,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Добавить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}