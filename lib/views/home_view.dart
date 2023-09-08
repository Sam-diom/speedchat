import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Bienvenue sur la page d'accueil !"),
            SizedBox(height: 20), // Espacement
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de connexion
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Se connecter"),
            ),
            SizedBox(height: 10), // Espacement
            OutlinedButton(
              onPressed: () {
                // Naviguer vers la page d'inscription
                Navigator.pushNamed(context, '/signup');
              },
              child: Text("S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}
