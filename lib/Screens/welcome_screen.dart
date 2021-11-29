import 'package:finance_app/Screens/profile_master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpg'),
            const SizedBox(
              height: 10,
            ),
            AnimatedButton(
              height: 50,
              width: 150,
              text: 'Start',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              onPress: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileMasterScreen(),
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
          ],
        ),
      ),
    );
  }
}
