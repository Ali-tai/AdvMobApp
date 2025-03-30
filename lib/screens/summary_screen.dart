import 'package:flutter/material.dart';
import 'package:nutri_tracker/screens/macros_screen.dart';
import 'package:nutri_tracker/screens/personal_info_screen.dart';
import 'package:nutri_tracker/screens/allergies_screen.dart';
import '../widgets/battery_indicator.dart';
import '../widgets/bottom_nav_bar.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Résumer'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => const MacrosScreen()),);},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStatePropertyAll(EdgeInsets.only( top: 40, bottom: 40)),
              side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BatteryIndicator(level: 0.3),
                Padding(padding: EdgeInsets.all(8)),
                BatteryIndicator(level: 0.6),
                Padding(padding: EdgeInsets.all(8)),
                BatteryIndicator(level: 1.0),
                Padding(padding: EdgeInsets.all(8)),
                BatteryIndicator(level: 0.4),
                Padding(padding: EdgeInsets.all(8)),
                BatteryIndicator(level: 0.6),
                Padding(padding: EdgeInsets.all(8)),
                BatteryIndicator(level: 0.1),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            onPressed: () => {Navigator.push(context,MaterialPageRoute(builder: (context) => const PersonalInfoScreen()))},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStatePropertyAll(EdgeInsets.only( top: 40, left: 100, right: 100, bottom: 40)),
              side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
            ),
            child: Column(
                  children: [
                    Text("Poids :   " + 85.toString() + " Kg", style: TextStyle(fontSize: 27)),
                    Padding(padding: EdgeInsets.all(10)),
                    Text("Taille : 	" + 180.toString() + " cm", style: TextStyle(fontSize: 27)),
                  ]
                )
          ),
          Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
              onPressed: () => {Navigator.push(context,MaterialPageRoute(builder: (context) => const AllergiesScreen()))},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStatePropertyAll(EdgeInsets.only( top: 20, left: 30, right: 30, bottom: 60)),
                side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
              ),
              child: Column(
                  children: [
                    Text("Allergies :" , style: TextStyle(fontSize: 30)),
                    Text("Liste des allergies, avec des, virgules, qui séparent, les allergies 	" , style: TextStyle(fontSize: 17)),
                  ]
              )
          ),
        ]
      ),
    );
    throw UnimplementedError();
    }
  }
