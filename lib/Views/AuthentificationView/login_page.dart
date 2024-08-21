import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyppo/Components/color.dart';
import 'package:hyppo/Components/my_button.dart';
import 'package:hyppo/Components/my_textfield.dart';
import 'package:hyppo/Components/square_tile.dart';
import 'package:hyppo/Views/AuthentificationView/signup_page.dart';
import 'package:hyppo/Views/HomeView/home_view.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Text editing controllers
  final usernameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: LoadingIndicator(
              indicatorType:
                  Indicator.ballClipRotatePulse, // Choisissez le type d'indicateur
              colors: const [primaryColor],
              strokeWidth: 2,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }

  // Method to sign in using username or email and password
  Future<void> signUserIn(BuildContext context) async {
    try {
      // Afficher l'indicateur de chargement
      showLoadingIndicator(context);

      String usernameOrEmail = usernameOrEmailController.text.trim();
      String password = passwordController.text.trim();

      // Étape 1 : Vérifier si l'entrée est un email ou un username
      bool isEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(usernameOrEmail);
      String email;

      if (isEmail) {
        // Si c'est un email, l'utiliser directement
        email = usernameOrEmail;
      } else {
        // Si c'est un username, récupérer l'email associé
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: usernameOrEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          email = querySnapshot.docs.first['email'];
        } else {
          // Masquer l'indicateur de chargement
          Navigator.pop(context);

          // Si aucun utilisateur n'est trouvé avec ce username
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username not found')),
          );
          return;
        }
      }

      // Étape 2 : Utiliser l'email pour se connecter
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Masquer l'indicateur de chargement
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed in as ${userCredential.user?.email}')),
      );

      // Rediriger l'utilisateur vers la page principale (HomePage par exemple)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeScreen()), // Remplacez `HomePage` par votre widget de page principale
      );
    } on FirebaseAuthException catch (e) {
      // Masquer l'indicateur de chargement
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Image(
                image: AssetImage("assets/logos/logo.png"),
                height: 120,
              ),
              const SizedBox(height: 15),
              const Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Discover Limitless Choices and Unmatched Convenience.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MyTextField(
                controller: usernameOrEmailController,
                hintText: 'Username or Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const Text("Remember me")
                      ],
                    ),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              MyButton(onTap: () => signUserIn(context), text: "Sign In"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'assets/logos/google.png'),
                  SizedBox(width: 25),
                  SquareTile(imagePath: 'assets/logos/apple.png')
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
