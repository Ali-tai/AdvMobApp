import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  // ⚖️ **Données utilisateur**
  double _weight = 80.0;
  int _height = 180;
  String _gender = "homme"; // "homme" ou "femme"
  int _age = 25;
  double _activityLevel = 1.55; // 1.2 - 1.9
  List<String> _allergies = [];

  // 🔵 **Valeurs actuelles consommées**
  int _energy = 0;
  int _carbs = 0;
  int _fats = 0;
  int _fiber = 0;
  int _protein = 0;
  int _salt = 0;

  // 🔴 **Besoins quotidiens max**
  int _maxEnergy = 2000;
  int _maxCarbs = 250;
  int _maxFats = 70;
  int _maxFiber = 30;
  int _maxProtein = 100;
  int _maxSalt = 5;

  // **Getters**
  double get weight => _weight;
  int get height => _height;
  String get gender => _gender;
  int get age => _age;
  double get activityLevel => _activityLevel;
  List<String> get allergies => _allergies;

  int get energy => _energy;
  int get carbs => _carbs;
  int get fats => _fats;
  int get fiber => _fiber;
  int get protein => _protein;
  int get salt => _salt;

  int get maxEnergy => _maxEnergy;
  int get maxCarbs => _maxCarbs;
  int get maxFats => _maxFats;
  int get maxFiber => _maxFiber;
  int get maxProtein => _maxProtein;
  int get maxSalt => _maxSalt;

  UserPreferences() {
    _loadPreferences();
  }

  /// 🔄 **Charger les données depuis SharedPreferences**
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _weight = prefs.getDouble('weight') ?? 80.0;
    _height = prefs.getInt('height') ?? 180;
    _gender = prefs.getString('gender') ?? "homme";
    _activityLevel = prefs.getDouble('activityLevel') ?? 1.55;
    _age = prefs.getInt('age') ?? 25;
    _allergies = prefs.getStringList('allergies') ?? [];

    _energy = prefs.getInt('energy') ?? 0;
    _carbs = prefs.getInt('carbs') ?? 0;
    _fats = prefs.getInt('fats') ?? 0;
    _fiber = prefs.getInt('fiber') ?? 0;
    _protein = prefs.getInt('protein') ?? 0;
    _salt = prefs.getInt('salt') ?? 0;

    _maxEnergy = prefs.getInt('maxEnergy') ?? 2000;
    _maxCarbs = prefs.getInt('maxCarbs') ?? 250;
    _maxFats = prefs.getInt('maxFats') ?? 70;
    _maxFiber = prefs.getInt('maxFiber') ?? 30;
    _maxProtein = prefs.getInt('maxProtein') ?? 100;
    _maxSalt = prefs.getInt('maxSalt') ?? 5;

    calculateNeeds(); // Recalculer les besoins en fonction des données actuelles
    resetDailyConsumption(); // Réinitialiser la consommation quotidienne
  }

  /// ⚖️ **Mettre à jour les données utilisateur**
  Future<void> setWeight(double newWeight) async {
    _weight = newWeight;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight', newWeight);
    calculateNeeds();
  }

  Future<void> setHeight(int newHeight) async {
    _height = newHeight;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('height', newHeight);
    calculateNeeds();
  }

  Future<void> setGender(String newGender) async {
    _gender = newGender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', newGender);
    calculateNeeds();
  }

  Future<void> setAge(int newAge) async {
    _age = newAge;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', newAge);
    calculateNeeds();
  }

  Future<void> setActivityLevel(double newActivityLevel) async {
    _activityLevel = newActivityLevel;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('activityLevel', newActivityLevel);
    calculateNeeds();
  }

  Future<void> setAllergies(List<String> newAllergies) async {
    _allergies = newAllergies;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('allergies', newAllergies);
    notifyListeners();
  }

  /// 🔢 **Calcul des besoins nutritionnels**
  void calculateNeeds(){
    // 🔹 Métabolisme de base (BMR) - Formule de Mifflin-St Jeor
    double bmr;

    if (_gender.toLowerCase() == "homme") {
      bmr = (10 * _weight) + (6.25 * _height) - (5 * _age) + 5;
    } else {
      bmr = (10 * _weight) + (6.25 * _height) - (5 * _age) - 161;
    }

    // 🔹 Besoins énergétiques totaux (TDEE)
    _maxEnergy = (bmr * _activityLevel).toInt();

    // 🔹 Répartition des macronutriments
    _maxCarbs = ((_maxEnergy * 0.55) / 4).toInt();  // 55% des kcal sous forme de glucides
    _maxFats = ((_maxEnergy * 0.30) / 9).toInt();   // 30% des kcal sous forme de lipides
    _maxProtein = ((_maxEnergy * 0.15) / 4).toInt(); // 15% des kcal sous forme de protéines
    _maxFiber = 35; // Valeur fixe
    _maxSalt = 5;   // Valeur fixe

    _saveMaxPreferences(); // Sauvegarder les nouvelles valeurs max
    notifyListeners();
  }

  /// 💾 **Sauvegarde des besoins max**
  Future<void> _saveMaxPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('maxEnergy', _maxEnergy);
    await prefs.setInt('maxCarbs', _maxCarbs);
    await prefs.setInt('maxFats', _maxFats);
    await prefs.setInt('maxFiber', _maxFiber);
    await prefs.setInt('maxProtein', _maxProtein);
    await prefs.setInt('maxSalt', _maxSalt);
  }

  /// ➕ **Ajouter à la consommation journalière**
  void addEnergy(int value) {
    _energy += value;
    notifyListeners();
  }

  void addCarbs(int value) {
    _carbs += value;
    notifyListeners();
  }

  void addFats(int value) {
    _fats += value;
    notifyListeners();
  }

  void addFiber(int value) {
    _fiber += value;
    notifyListeners();
  }

  void addProtein(int value) {
    _protein += value;
    notifyListeners();
  }

  void addSalt(int value) {
    _salt += value;
    notifyListeners();
  }

  /// 🔄 **Réinitialiser la consommation quotidienne**
  void resetDailyConsumption() {
    _energy = 0;
    _carbs = 0;
    _fats = 0;
    _fiber = 0;
    _protein = 0;
    _salt = 0;
    notifyListeners();
  }
}
