import 'package:flutter/material.dart';
import 'package:uzacontact/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uza Contacts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'IndieFlower'),
          titleLarge: TextStyle(fontSize: 16, color: Colors.green),
        ),
        useMaterial3: true,
      ),
      home: const Homepage(
        title: 'Contacts',
      ),
    );
  }
}
