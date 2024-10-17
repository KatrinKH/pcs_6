import 'package:flutter/material.dart';

class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() {
    return _instance;
  }

  UserData._internal();

  String name = 'Unknown';
  String group = 'Unknown'; 
  String email = 'example@gmail.com';
  String city = 'Москва';

  void updateUserData(String newName, String newGroup, String newEmail, String newCity) {
    name = newName;
    group = newGroup; 
    email = newEmail;
    city = newCity;
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserData _userData = UserData();

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController(text: _userData.name);
        final TextEditingController groupController = TextEditingController(text: _userData.group);
        final TextEditingController emailController = TextEditingController(text: _userData.email);
        final TextEditingController cityController = TextEditingController(text: _userData.city);

        return AlertDialog(
          title: const Text('Редактировать профиль'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Имя Фамилия')),
                TextField(controller: groupController, decoration: const InputDecoration(labelText: 'Группа')),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Почта'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(controller: cityController, decoration: const InputDecoration(labelText: 'Город')),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Сохранить'),
              onPressed: () {
                _userData.updateUserData(
                  nameController.text,
                  groupController.text,
                  emailController.text,
                  cityController.text,
                );
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Профиль')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile/unknown.jpg')),
              const SizedBox(height: 20),

              Text(
                _userData.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Группа:', style: TextStyle(fontSize: 16, color: Colors.grey)), 
                  const SizedBox(width: 10),
                  Text(_userData.group, style: const TextStyle(fontSize: 16)), 
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Почта:', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(width: 10),
                  Text(_userData.email, style: const TextStyle(fontSize: 16))]),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Город:', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(width: 10),
                  Text(_userData.city, style: const TextStyle(fontSize: 16))]),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _editProfile,
                child: const Text('Редактировать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
