import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: const Center(
        child: Text(
          'Selamat Datang! Anda berhasil login.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}