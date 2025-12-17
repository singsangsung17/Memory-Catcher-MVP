import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MemoryCatcherApp());
}

class MemoryCatcherApp extends StatelessWidget {
  const MemoryCatcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Catcher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
