import 'package:financer/screens/main_page.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../components/buttons/rounded_button.dart';
import '../components/financer_logo_image.dart';

class LoginEmail extends StatefulWidget {
  static String route = '/login/email';

  const LoginEmail({super.key});
  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const FinancerLogoImage(),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputBoxDecoration,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kInputBoxDecoration.copyWith(
                    labelText: 'Password',
                    hintText: 'Enter your Password here...',
                  )),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: const Color(0xFFFF304B),
                onTapFunc: () {
                  Navigator.pushNamed(context, MainPage.route);
                },
                btnTxt: 'Log In',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Log In with Mobile',
                  style: kLinkTxtStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
