import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/bottom_nav_bar.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _weightController = TextEditingController(text: "85");
  final TextEditingController _heightController = TextEditingController(text: "182");

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Infos Perso'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Poids :",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        style: const TextStyle(fontSize: 28),
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const Text("Kg", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Taille :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        style: const TextStyle(fontSize: 28),
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const Text("cm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
  }
}
