
import 'package:flutter/material.dart';
import 'package:scanner/scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QRScanner(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.tealAccent)),
    );
  }
}
