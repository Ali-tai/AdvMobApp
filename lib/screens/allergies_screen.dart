import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  _AllergiesScreenState createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  final TextEditingController _allergiesController = TextEditingController(text: "Amandes, Lait, Pain, Noix");

  @override
  void dispose() {
    _allergiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Allergies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),textAlign: TextAlign.center,)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: _allergiesController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
  }
}
