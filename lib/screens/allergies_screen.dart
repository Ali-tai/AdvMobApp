import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_preferences.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  _AllergiesScreenState createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  late TextEditingController _allergiesController;
  late UserPreferences userPrefs;

  @override
  void initState() {
    super.initState();
    userPrefs = Provider.of<UserPreferences>(context, listen: false);
    _allergiesController = TextEditingController(text: userPrefs.allergies.join(', '));
  }

  @override
  void dispose() {
    userPrefs.setAllergies(
      _allergiesController.text.split(',').map((e) => e.trim()).toList(),
    );
    _allergiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // important pour clavier
      appBar: AppBar(
        title: const Text(
          "Allergies",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                  decoration: const InputDecoration.collapsed(
                    hintText: "Entrez vos allergies (séparées par des virgules)",
                  ),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
