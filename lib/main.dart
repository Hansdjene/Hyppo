import 'package:flutter/material.dart';
import 'package:hyppo/Views/AuthentificationView/login_page.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/Models/global_bloc.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/home_reminder_page.dart';
import 'package:hyppo/Views/HomeView/Tools/tools_page.dart';
import 'package:hyppo/Views/HomeView/home_view.dart';
import 'package:hyppo/Views/OnboardingView/onboarding_view.dart';
import 'package:hyppo/Theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;

  runApp(MyApp(onboarding: onboarding));
}

class MyApp extends StatefulWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
        value: globalBloc!,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          home: widget.onboarding ? LoginPage() : const OnboardingView(),
        ));
  }
}
