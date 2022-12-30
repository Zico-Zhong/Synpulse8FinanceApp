import 'package:flutter/material.dart';
import 'package:financer/components/buttons/rounded_button.dart';
import '../components/financer_logo_image.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  static String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF3F8),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FinancerLogoImage(),
              const SizedBox(
                height: 36.0,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Financer',
                    textStyle: const TextStyle(
                      fontSize: 62.0,
                      fontFamily: 'Audiowide-Regular',
                    ),
                    colors: [
                      Colors.purpleAccent,
                      Colors.purple,
                      Colors.deepPurpleAccent,
                    ],
                    speed: const Duration(milliseconds: 420),
                  ),
                ],
                isRepeatingAnimation: true,
                totalRepeatCount: 10,
              ),
              const SizedBox(
                height: 30.0,
              ),
              RoundedButton(
                color: const Color(0xFFFF304B),
                btnTxt: 'Login',
                onTapFunc: () {
                  Navigator.pushNamed(context, '/login/mobile');
                },
              ),
              RoundedButton(
                color: const Color(0xFFFF304B),
                btnTxt: 'Register',
                onTapFunc: () {
                  Navigator.pushNamed(context, '/register/mobile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
