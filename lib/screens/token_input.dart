import 'package:financer/screens/main_page.dart';
import 'package:financer/utilities/token_page_arguments.dart';
import 'package:flutter/material.dart';

import '../components/buttons/rounded_button.dart';
import '../utilities/constants.dart';
import '../utilities/app_action.dart';

import 'package:flutter_verification_code/flutter_verification_code.dart';

class TokenInput extends StatefulWidget {
  const TokenInput({Key? key}) : super(key: key);

  static String route = '/token';

  @override
  State<TokenInput> createState() => _TokenInputState();
}

class _TokenInputState extends State<TokenInput> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TokenPageArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  color: const Color(0xFFFF304B),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: const Icon(
                              Icons.menu,
                              size: 36.0,
                              color: Colors.white,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.notifications_none,
                              size: 36.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        args.action == AppAction.register
                            ? 'Sign Up !'
                            : 'Sign In !',
                        style: kTitleTxtStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 274,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 88.0,
                      ),
                      const Text(
                        'Didn\'t Receive an OTP ?',
                        style: kLabelTxtStyle,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Resend OTP',
                          style: kLinkTxtStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      RoundedButton(
                        color: const Color(0xFFFF304B),
                        btnTxt: args.action == AppAction.login
                            ? 'Log In'
                            : 'Register',
                        onTapFunc: () {
                          if (args.action == AppAction.login) {
                            Navigator.pushNamed(context, MainPage.route);
                          } else if (args.action == AppAction.register) {
                            Navigator.pushNamed(context, '/register/email');
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 160,
              left: 32,
              right: 32,
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: -10,
                      blurRadius: 10,
                      offset: const Offset(0, 15),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter OTP',
                      style: kLabelTxtStyle,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 32.0,
                        right: 32.0,
                      ),
                      child: VerificationCode(
                        onCompleted: (value) {},
                        onEditing: (value) {},
                        textStyle: kInputTxtStyle,
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
