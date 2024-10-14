import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'), // Заголовок для экрана профиля
      ),
      body: const Center(
        child: Text('Это профиль пользователя.'),
      ),
    );
  }
}
