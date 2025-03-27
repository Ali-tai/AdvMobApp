import 'package:flutter/material.dart';
import 'package:nutri_tracker/screens/scan_screen.dart';
import 'package:nutri_tracker/screens/summary_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Image.asset("assets/image/Image_home.jpg",scale: 2.5),
            Padding(padding: EdgeInsets.all(10)),
            Text('Welcome to NutriTrack', style: TextStyle(fontSize: 28)),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () => SummaryScreen(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStatePropertyAll(EdgeInsets.only(left: 80, top: 10, right: 80, bottom: 10)),
                side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Image.asset("assets/image/Coeur_home.jpg",scale: 2.5)
          ],),
      ),
    );
  }
}