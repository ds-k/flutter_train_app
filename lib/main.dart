import 'package:flutter/material.dart';
import 'package:flutter_train_app/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        cardColor: Colors.white,
        scaffoldBackgroundColor: Colors.grey[200],
        // scaffoldBackgroundColor: Color.fromRGBO(255, 246, 249, 1),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        cardColor: Colors.grey[800],
      ),
      home: HomePage(),
    );
  }
}
