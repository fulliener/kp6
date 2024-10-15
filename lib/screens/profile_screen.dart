import 'package:flutter/material.dart';
import 'profile_settings_screen.dart'; // Экран настроек профиля
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = "Руслан"; // Изначальное имя
  String lastName = "Акперов"; // Изначальная фамилия

  @override
  void initState() {
    super.initState();
    // Загружаем сохраненные данные при инициализации
    _loadProfileData();
  }

  // Загружаем сохраненные данные
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? firstName;
      lastName = prefs.getString('lastName') ?? lastName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              // Переход к экрану настроек профиля
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettingsScreen(),
                ),
              );

              // Обновляем данные после возврата из настроек
              _loadProfileData(); // Перезагружаем данные профиля
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Здравствуйте, $firstName', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text('Это профиль пользователя.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
