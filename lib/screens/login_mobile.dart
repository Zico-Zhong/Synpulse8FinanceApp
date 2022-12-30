import 'package:financer/components/buttons/rounded_button.dart';
import 'package:financer/utilities/app_action.dart';
import 'package:financer/utilities/constants.dart';
import 'package:financer/utilities/token_page_arguments.dart';
import 'package:flutter/material.dart';
import '../components/cards/mobile_input_card.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  static String route = '/login/mobile';

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
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
                        'Sign In !',
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Still not have an account ?',
                        style: kLabelTxtStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register/mobile');
                        },
                        child: const Text(
                          'Sign up',
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
                              arguments: TokenPageArguments(AppAction.login));
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login/email');
                        },
                        child: const Text(
                          'Log In with Email and Password',
                          style: kLinkTxtStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
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
