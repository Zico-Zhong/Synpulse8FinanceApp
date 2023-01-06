import 'package:financer/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../components/buttons/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterEmail extends StatefulWidget {
  static String route = '/register/email';
  const RegisterEmail({Key? key}) : super(key: key);

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String currErr = 'EMPTY';
  bool errShows = false;
  Map<String, String> errMsg = {
    'EMPTY': 'Please fill all the blanks in the form!',
    'PASSWORDNOTMATCH':
        'Your password and confirming password is not matched, please check and enter again!'
  };
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  color: const Color(0xFFFF304B),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 42.0, left: 10.0),
                    child: Text(
                      'One more step to go...',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 274,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundedButton(
                        color: const Color(0xFFFF304B),
                        btnTxt: 'Register',
                        onTapFunc: () {
                          if (password != confirmPassword) {
                            currErr = 'PASSWORDNOTMATCH';
                            setState(() {
                              errShows = true;
                            });
                          } else if (email.isEmpty ||
                              password.isEmpty ||
                              confirmPassword.isEmpty) {
                            currErr = 'EMPTY';
                            setState(() {
                              errShows = true;
                            });
                          } else {
                            setState(() {
                              errShows = false;
                            });
                            try {
                              final newUser =
                                  _auth.createUserWithEmailAndPassword(
                                      email: 'zzh15989022638@gmail.com',
                                      password: '123456');
                              if (newUser != null) {
                              } else {}
                            } catch (e) {
                              print(e);
                            }
                            Navigator.pushNamed(context, Welcome.route);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 42.0,
                      ),
                      Visibility(
                        visible: errShows,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 20.0),
                          child: Text(
                            errMsg[currErr]!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 140,
              left: 32,
              right: 32,
              child: Container(
                height: 260.0,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kInputBoxDecoration.copyWith(
                          labelText: 'Email',
                          hintText: 'Enter your Email here...',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF304B), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF304B), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                      TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kInputBoxDecoration.copyWith(
                          labelText: 'Password',
                          hintText: 'Enter your Password here...',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF304B), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF304B), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                      TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        decoration: kInputBoxDecoration.copyWith(
                          labelText: 'Confirm Password',
                          hintText: 'Enter your Password again here...',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF304B), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF304B), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
