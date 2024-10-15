import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  EditProfileScreen({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final updatedData = {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'phoneNumber': phoneNumberController.text,
      'email': emailController.text,
    };

    // Возвращаем обновленные данные на экран настроек профиля
    Navigator.pop(context, updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Сохранить',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Фамилия'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Телефон'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
      ),
    );
  }
}
