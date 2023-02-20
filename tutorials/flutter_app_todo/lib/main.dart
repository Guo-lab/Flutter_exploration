// ignore_for_file: unused_import, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/auth/authpage.dart';
import 'package:flutter_app_todo/displays/home.dart';


import 'package:firebase_core/firebase_core.dart'; //@ https://dart-lang.github.io/linter/lints/depend_on_referenced_packages.html



void main() async {
  WidgetsFlutterBinding.ensureInitialized();  //@ "https://www.youtube.com/watch?v=y1763PWQ0JM" and "https://qiita.com/mamoru_takami/items/87a20d861806a70db29d"
  await Firebase.initializeApp();

  runApp(const MyApp());
}
//void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      //home: AuthPage(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), // The argument type 'Stream<User?> Function()' can't be assigned to the parameter type 'Stream<Object?>? 原来是 function() 的问题
        builder: (context, usersnapshot) { //@ https://stackoverflow.com/questions/67049608/what-is-a-snapshot-in-flutter
          if (usersnapshot.hasData && usersnapshot.connectionState == ConnectionState.active) {
            //print(usersnapshot.data);
            return HomePage();
          } else {
            //print(usersnapshot.data);
            return AuthPage();
          }
        },
      ),

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
