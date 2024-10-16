import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String name = 'Хомик Екатерина Андреевна';
  final String group = 'ЭФБО-06-22';
  final String phoneNumber = '+7 (123) 456-78-90';
  final String email = 'example@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Профиль')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ФИО', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            const Text('Группа', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(group, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            const Text('Номер телефона', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(phoneNumber, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            const Text('Почта', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
