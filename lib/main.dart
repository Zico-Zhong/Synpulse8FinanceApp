import 'package:financer/screens/gainers_losers_all.dart';
import 'package:financer/screens/login_email.dart';
import 'package:financer/screens/login_mobile.dart';
import 'package:financer/screens/main_page.dart';
import 'package:financer/screens/register_email.dart';
import 'package:financer/screens/register_mobile.dart';
import 'package:financer/screens/token_input.dart';
import 'package:financer/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() => (runApp(const Financer()));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Financer());
}

class Financer extends StatelessWidget {
  const Financer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Landing.route,
      routes: {
        Landing.route: (context) => const Landing(),
        LoginMobile.route: (context) => const LoginMobile(),
        LoginEmail.route: (context) => const LoginEmail(),
        SignupMobile.route: (context) => const SignupMobile(),
        TokenInput.route: (context) => const TokenInput(),
        RegisterEmail.route: (context) => const RegisterEmail(),
        Welcome.route: (context) => const Welcome(),
        MainPage.route: (context) => const MainPage(),
        GainersLosers.route: (context) => const GainersLosers(),
      },
    );
  }
}
