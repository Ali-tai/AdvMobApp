import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userinfo with ChangeNotifier {
  double _weight = 85;
  double _height = 182;
  List<String> _allergies = [];

  double get weight => _weight;
  double get height => _height;
  List<String> get allergies => _allergies;

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _weight = prefs.getDouble('weight') ?? 85;
    _height = prefs.getDouble('height') ?? 182;
    _allergies = prefs.getStringList('allergies') ?? [];
    notifyListeners();
  }

  Future<void> updateWeight(double newWeight) async {
    _weight = newWeight;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight', newWeight);
    notifyListeners();
  }

  Future<void> updateAllergies(List<String> newAllergies) async {
    _allergies = newAllergies;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('allergies', newAllergies);
    notifyListeners();
  }
}
