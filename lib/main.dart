import 'package:flutter/material.dart';
import 'Tache4_app.dart';


void main() {
  runApp(TextRecognitionApp());
}

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      
      },
    );
  }
}
