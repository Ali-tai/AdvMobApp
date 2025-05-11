import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // <-- Ajouté
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          localizations.allergiesTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                  border: Border.all(color: userPrefs.textColor),
                ),
                child: TextField(
                  controller: _allergiesController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration.collapsed(
                    hintText: localizations.allergiesHint,
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
