import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_preferences.dart';
import '../widgets/bottom_nav_bar.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);

    final TextEditingController weightController =
    TextEditingController(text: userPrefs.weight.toString());
    final TextEditingController heightController =
    TextEditingController(text: userPrefs.height.toString());
    final TextEditingController ageController =
    TextEditingController(text: userPrefs.age.toString());

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
                    const Text("Poids :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        style: const TextStyle(fontSize: 28),
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onSubmitted: (value) {
                          final newWeight = double.tryParse(value);
                          if (newWeight != null) {
                            userPrefs.setWeight(newWeight);
                          }
                        },
                      ),
                    ),
                    const Text("Kg", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Taille :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        style: const TextStyle(fontSize: 28),
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onSubmitted: (value) {
                          final newHeight = double.tryParse(value);
                          if (newHeight != null) {
                            userPrefs.setHeight(newHeight);
                          }
                        },
                      ),
                    ),
                    const Text("cm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Age :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        style: const TextStyle(fontSize: 28),
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onSubmitted: (value) {
                          final newage = int.tryParse(value);
                          if (newage != null) {
                            userPrefs.setAge(newage);
                          }
                        },
                      ),
                    ),
                    const Text("ans", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () => {userPrefs.setGender("homme")},
                        style: ButtonStyle(
                          backgroundColor: userPrefs.gender == "homme" ? MaterialStateProperty.all(Colors.blue) : MaterialStateProperty.all(Colors.white),
                        ),
                        child: Text(
                            "Homme",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: userPrefs.gender == "homme" ? Colors.white : Colors.black,
                            ),
                        )
                    ),
                    ElevatedButton(
                        onPressed: () => {userPrefs.setGender("femme")},
                        style: ButtonStyle(
                          backgroundColor: userPrefs.gender == "femme" ? MaterialStateProperty.all(Colors.pink) : MaterialStateProperty.all(Colors.white),
                        ),
                        child: Text(
                          "Femme",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: userPrefs.gender == "femme" ? Colors.white : Colors.black,
                          ),
                        )
                    ),
                  ]
                ),
                const SizedBox(height: 10),
                //activité physique
                Text("Taux d'activité : ${userPrefs.activityLevel.toStringAsFixed(1)}",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Slider(
                  value: userPrefs.activityLevel,
                  min: 1.2,
                  max: 1.9,
                  divisions: 5, // Ajoute des crans (facultatif)
                  label: userPrefs.activityLevel.toStringAsFixed(1),
                  activeColor: userPrefs.gender == "femme" ? Colors.pink : Colors.blue, // Couleur du curseur
                  inactiveColor: Colors.grey[300], // Couleur de la ligne inactive
                  onChanged: (double value) {
                    userPrefs.setActivityLevel(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}