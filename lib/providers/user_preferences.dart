import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  // ⚖️ **Données utilisateur**
  double _weight = 80.0;
  int _height = 180;
  String _gender = "homme"; // "homme" ou "femme"
  int _age = 25;
  double _activityLevel = 1.55; // 1.2 - 1.9
  String _lastResetDate = DateTime(2000, 1, 1).toIso8601String();
  List<String> _allergies = [];
  String _language = "fr";
  ThemeMode _themeMode = ThemeMode.system;

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
  String get lastResetDate => _lastResetDate;
  List<String> get allergies => _allergies;
  String get language => _language;
  ThemeMode get themeMode => _themeMode;

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
    _lastResetDate = prefs.getString(_lastResetDate) ?? DateTime(2000, 1, 1).toIso8601String();
    _allergies = prefs.getStringList('allergies') ?? [];
    _language = prefs.getString('language') ?? "fr";
    _themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];

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
    if (_lastResetDate != null) {
      final ResetDate = DateTime.tryParse(_lastResetDate);
      if (ResetDate != null &&
          ResetDate.year < DateTime.now().year ||
          ResetDate!.month < DateTime.now().month ||
          ResetDate.day < DateTime.now().day) {
        resetDailyConsumption();
        await prefs.setString(_lastResetDate, DateTime.now().toIso8601String());
      }
    } else {
      // Première utilisation ou date non trouvée, on initialise
      resetDailyConsumption();
      await prefs.setString(_lastResetDate, DateTime.now().toIso8601String());
    }
    notifyListeners();
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

  Future<void> setLanguage(String newLanguage) async {
    _language = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLanguage);
    notifyListeners();
  }
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    _themeMode = newThemeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', newThemeMode.index);
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

  Future<void> setEnergy(int value) async{
    _energy = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('energy', value);
  }
  Future<void> setCarbs(int value) async{
    _carbs = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('carbs', value);
  }
  Future<void> setFats(int value) async{
    _fats = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fats', value);
  }
  Future<void> setFiber(int value) async{
    _fiber = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fiber', value);
  }
  Future<void> setProtein(int value) async{
    _protein = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('protein', value);
  }
  Future<void> setSalt(int value) async{
    _salt = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('salt', value);
  }

  /// ➕ **Ajouter à la consommation journalière**
  void addEnergy(int value) {
    _energy += value;
    setEnergy(_energy);
    notifyListeners();
  }

  void addCarbs(int value) {
    _carbs += value;
    setCarbs(_carbs);
    notifyListeners();
  }

  void addFats(int value) {
    _fats += value;
    setFats(_fats);
    notifyListeners();
  }

  void addFiber(int value) {
    _fiber += value;
    setFiber(_fiber);
    notifyListeners();
  }

  void addProtein(int value) {
    _protein += value;
    setProtein(_protein);
    notifyListeners();
  }

  void addSalt(int value) {
    _salt += value;
    setSalt(_salt);
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

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  // Méthode pour obtenir la couleur de fond en fonction du mode
  Color get backgroundColor => _themeMode == ThemeMode.dark ? Colors.black : Colors.white;

  // Méthode pour obtenir la couleur du texte en fonction du mode
  Color get textColor => _themeMode == ThemeMode.dark ? Colors.white : Colors.black;

  // Méthode pour obtenir la couleur de l'appBar en fonction du mode
  Color get appBarColor => _themeMode == ThemeMode.dark ? Colors.grey : Colors.blue;

  // Méthode pour obtenir la couleur des boutons en fonction du mode
  Color get buttonColor => _themeMode == ThemeMode.dark ? Colors.blueGrey : Colors.blue;

  Color get genderColor => _gender == "homme" ? Colors.blue : Colors.pink;
}
