import 'package:flutter/material.dart';
import 'package:nutri_tracker/widgets/MainScreenWithNavigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(20)),
            Image.asset("assets/image/Image_home.jpg", scale: 2.5),
            const Padding(padding: EdgeInsets.all(10)),
            const Text('Welcome to NutriTrack', style: TextStyle(fontSize: 28)),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainScreenWithNavigation(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                ),
                side: const MaterialStatePropertyAll(BorderSide(color: Colors.black)),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Image.asset("assets/image/Coeur_home.jpg", scale: 2.5)
          ],
        ),
      ),
    );
  }
}
