import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_preferences.dart';
import '../../../providers/locale_provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    final local = AppLocalizations.of(context)!;

    final TextEditingController weightController = TextEditingController(
        text: userPrefs.weight.toString());
    final TextEditingController heightController = TextEditingController(
        text: userPrefs.height.toString());
    final TextEditingController ageController = TextEditingController(
        text: userPrefs.age.toString());

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
        title: Text(local.personalInfo, style: TextStyle(color: userPrefs.textColor)),
        centerTitle: true,
        backgroundColor: userPrefs.appBarColor,
        actions: [
          IconButton(
            icon: Icon(
              userPrefs.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              color: userPrefs.textColor,
            ),
            tooltip: userPrefs.themeMode == ThemeMode.dark ? local.lightMode : local.darkMode,
            onPressed: () => userPrefs.toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: userPrefs.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Poids
                    _infoRow(
                      label: local.weight,
                      controller: weightController,
                      suffix: local.kg,
                      textColor: userPrefs.textColor,
                      onSubmitted: (value) {
                        final newWeight = double.tryParse(value);
                        if (newWeight != null) userPrefs.setWeight(newWeight);
                      },
                    ),
                    const SizedBox(height: 10),

                    /// Taille
                    _infoRow(
                      label: local.height,
                      controller: heightController,
                      suffix: local.cm,
                      textColor: userPrefs.textColor,
                      onSubmitted: (value) {
                        final newHeight = int.tryParse(value);
                        if (newHeight != null) userPrefs.setHeight(newHeight);
                      },
                    ),
                    const SizedBox(height: 10),

                    /// Age
                    _infoRow(
                      label: local.age,
                      controller: ageController,
                      suffix: local.years,
                      textColor: userPrefs.textColor,
                      onSubmitted: (value) {
                        final newAge = int.tryParse(value);
                        if (newAge != null) userPrefs.setAge(newAge);
                      },
                    ),
                    const SizedBox(height: 20),

                    /// Genre
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _genderButton(context, userPrefs, "homme", local.male, userPrefs.textColor, userPrefs.buttonColor),
                        _genderButton(context, userPrefs, "femme", local.female, userPrefs.textColor, userPrefs.buttonColor),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Activité physique
                    Text("${local.activityLevel} : ${userPrefs.activityLevel
                        .toStringAsFixed(1)}",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: userPrefs.textColor)),
                    Slider(
                      value: userPrefs.activityLevel,
                      min: 1.2,
                      max: 1.9,
                      divisions: 5,
                      label: userPrefs.activityLevel.toStringAsFixed(1),
                      activeColor: userPrefs.gender == "femme" ? Colors.pink : Colors.blue,
                      inactiveColor: Colors.grey[300],
                      onChanged: (double value) {
                        userPrefs.setActivityLevel(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(local.notActive, style: TextStyle(fontSize: 14, color: userPrefs.textColor)),
                        Text(local.veryActive, style: TextStyle(fontSize: 14, color: userPrefs.textColor)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Langue
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _langButton(context, userPrefs, "fr", local.french, userPrefs.textColor, userPrefs.buttonColor),
                        _langButton(context, userPrefs, "en", local.english, userPrefs.textColor, userPrefs.buttonColor),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow({
    required String label,
    required TextEditingController controller,
    required String suffix,
    required Color textColor,
    required void Function(String) onSubmitted,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$label :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: textColor)),
        SizedBox(
          width: 80,
          child: TextField(
            style: TextStyle(fontSize: 28, color: textColor),
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(border: InputBorder.none),
            onSubmitted: onSubmitted,
          ),
        ),
        Text(suffix, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: textColor)),
      ],
    );
  }

  Widget _genderButton(BuildContext context, UserPreferences userPrefs,
      String value, String label, Color textColor, Color buttonColor) {
    final bool selected = userPrefs.gender == value;
    return ElevatedButton(
      onPressed: () => userPrefs.setGender(value),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
            selected ? userPrefs.genderColor : buttonColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: selected ? Colors.white : textColor,
        ),
      ),
    );
  }

  Widget _langButton(BuildContext context, UserPreferences userPrefs,
      String code, String label, Color textColor, Color buttonColor) {
    final bool selected = userPrefs.language == code;
    return ElevatedButton(
      onPressed: () {
        userPrefs.setLanguage(code);
        final locale = Locale(code);
        Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
            selected ? userPrefs.genderColor : buttonColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: selected ? Colors.white : textColor,
        ),
      ),
    );
  }
}
