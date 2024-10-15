import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  String phoneNumber = "+7 (926) 674-61-78";
  String firstName = "Руслан";
  String lastName = "Акперов";
  String email = "ruslanakperov@gmail.ru";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Загружаем сохраненные данные
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? firstName;
      lastName = prefs.getString('lastName') ?? lastName;
      phoneNumber = prefs.getString('phoneNumber') ?? phoneNumber;
      email = prefs.getString('email') ?? email;
    });
  }

  // Сохраняем данные
  Future<void> _saveProfileData(String firstName, String lastName, String phoneNumber, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    firstName: firstName,
                    lastName: lastName,
                    phoneNumber: phoneNumber,
                    email: email,
                  ),
                ),
              );

              if (result != null) {
                setState(() {
                  firstName = result['firstName'] ?? firstName;
                  lastName = result['lastName'] ?? lastName;
                  phoneNumber = result['phoneNumber'] ?? phoneNumber;
                  email = result['email'] ?? email;
                });
                await _saveProfileData(firstName, lastName, phoneNumber, email);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor, // Используем цвет карты из темы
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Личные данные',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(phoneNumber, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('$firstName $lastName', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text(email, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
