import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyppo/Components/color.dart';
import 'package:hyppo/Components/my_button.dart';
import 'package:hyppo/Components/my_textfield.dart';
import 'package:hyppo/Components/square_tile.dart';
import 'package:hyppo/Views/HomeView/home_view.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  // Text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Méthode pour afficher l'indicateur de chargement
  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: LoadingIndicator(
              indicatorType: Indicator
                  .ballClipRotatePulse, // Choisissez le type d'indicateur
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

  // Sign user up method
  void signUserUp(BuildContext context) async {
    try {
      // Afficher l'indicateur de chargement
      showLoadingIndicator(context);

      // Créer un nouvel utilisateur avec Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Récupérer l'UID de l'utilisateur
      String uid = userCredential.user!.uid;

      // Stocker les informations de l'utilisateur dans Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': usernameController.text,
        'email': emailController.text,
        'created_at': Timestamp.now(),
      });

      // Masquer l'indicateur de chargement
      Navigator.pop(context);

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );

      // Rediriger l'utilisateur vers la page principale (Home)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Masquer l'indicateur de chargement
      Navigator.pop(context);

      // Gérer les erreurs d'inscription
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: const IconThemeData(
          color:
              primaryColor, // Change la couleur de la flèche de retour en vert
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                const Text(
                  'Let\'s create your account!',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    'Discover Limitless Choices and Unmatched Convenience.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text("I agree to Privacy Policy and Terms of use"),
                  ],
                ),
                const SizedBox(height: 25),
                MyButton(
                  onTap: () => signUserUp(context),
                  text: "Create Account",
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SquareTile(imagePath: 'assets/logos/google.png'),
                    SizedBox(width: 25),
                    SquareTile(imagePath: 'assets/logos/apple.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
