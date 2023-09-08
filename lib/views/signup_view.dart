import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email = "";
  String? _password = "";
  String? _displayName = "";

  Future<void> _inscription() async {
    final formState = _formKey.currentState;
    if (formState?.validate() ?? false) {
      formState?.save();
      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        // L'utilisateur est enregistré avec succès, vous pouvez ajouter les données à Firestore.
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'displayName': _displayName,
          'email': _email,
        });

        // Redirigez l'utilisateur vers la page de connexion après l'inscription réussie.
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        // Gestion des erreurs d'inscription ici
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inscription"),
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
                TextFormField(
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Entrez un nom d'utilisateur";
                    }
                    return null;
                  },
                  onSaved: (input) => _displayName = input!,
                  decoration: InputDecoration(labelText: "Nom d'utilisateur"),
                ),
                ElevatedButton(
                  onPressed: _inscription,
                  child: Text("S'inscrire"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
