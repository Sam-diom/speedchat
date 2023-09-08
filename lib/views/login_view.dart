import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email = ""; // Utilisez String? au lieu de String
  String? _password = ""; // Utilisez String? au lieu de String

  Future<void> _connexion() async {
    final formState = _formKey.currentState;
    if (formState?.validate() ?? false) {
      // Utilisez ?.validate() ?? false
      formState?.save(); // Utilisez ?.save()

      try {
        await _auth.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        // L'utilisateur est connecté avec succès, vous pouvez rediriger ici
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        // Gestion des erreurs de connexion ici
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connexion"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Entrez une adresse e-mail valide";
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input!,
                  decoration: InputDecoration(labelText: "E-mail"),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Entrez un mot de passe valide";
                    }
                    return null;
                  },
                  onSaved: (input) => _password = input!,
                  decoration: InputDecoration(labelText: "Mot de passe"),
                ),
                ElevatedButton(
                  // Utilisez ElevatedButton au lieu de RaisedButton
                  onPressed: _connexion,
                  child: Text("Se connecter"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
