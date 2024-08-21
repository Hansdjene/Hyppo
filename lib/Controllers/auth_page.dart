import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyppo/Views/AuthentificationView/login_page.dart';
import 'package:hyppo/Views/HomeView/home_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HomeScreen(); // Utilisateur connecté
          } else {
            return LoginPage(); // Utilisateur non connecté
          }
        }
        return CircularProgressIndicator(); // Indicateur de chargement
      },
    ));
  }
}
