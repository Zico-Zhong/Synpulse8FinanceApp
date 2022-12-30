import 'package:financer/components/buttons/rounded_button.dart';
import 'package:financer/components/cards/mobile_input_card.dart';
import 'package:financer/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../utilities/app_action.dart';
import '../utilities/token_page_arguments.dart';

class SignupMobile extends StatefulWidget {
  const SignupMobile({Key? key}) : super(key: key);

  static String route = '/register/mobile';

  @override
  State<SignupMobile> createState() => _SignupMobileState();
}

class _SignupMobileState extends State<SignupMobile> {
  @override
  Widget build(BuildContext context) {
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
                      const Text(
                        'Sign Up !',
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
                        'Already have an account ?',
                        style: kLabelTxtStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login/mobile');
                        },
                        child: const Text(
                          'Sign in',
                          style: kLinkTxtStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      RoundedButton(
                        color: const Color(0xFFFF304B),
                        btnTxt: 'Submit',
                        onTapFunc: () {
                          Navigator.pushNamed(context, '/token',
                              arguments:
                                  TokenPageArguments(AppAction.register));
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
                child: const MobileInputCard(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
