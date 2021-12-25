import 'package:finance_app/Screens/login_screen.dart';
import 'package:finance_app/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset('assets/logo.png'),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 150,
            ),
            AnimatedButton(
              height: 40,
              width: 150,
              text: 'Signup',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              onPress: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
              textStyle: const TextStyle(
                fontSize: 20,
                letterSpacing: 5,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: Colors.blue,
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 2,
            ),
            AnimatedButton(
              height: 40,
              width: 150,
              text: 'login',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              onPress: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              textStyle: const TextStyle(
                fontSize: 20,
                letterSpacing: 5,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: Colors.blue,
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 2,
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
