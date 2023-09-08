import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './views/home_view.dart';
import './views/signup_view.dart';
import './views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialisation de Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home', // Route initiale
      routes: {
        '/home': (context) => HomeView(),
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
