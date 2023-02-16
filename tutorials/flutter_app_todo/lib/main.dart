import 'package:flutter/material.dart';
import 'package:flutter_app_todo/auth/authpage.dart';

//import 'package:flutter_app_todo/displays/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
      title: 'ToDo APP Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.light().copyWith(primary: Colors.orange[400]),
      ),
    );
  }
}
