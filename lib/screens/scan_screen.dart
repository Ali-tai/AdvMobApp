import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/user_preferences.dart';
import '../services/open_food_facts_service.dart';
import '../providers/product.dart';
import 'info_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';
  Product? _scannedProduct;
  bool? _isSafe;
  final OpenFoodFactsService _openFoodFactsService = OpenFoodFactsService();
  bool _isProcessing = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool _checkAllergies(Product product, List<String> allergyKeys, AppLocalizations localizations) {
    if (product.ingredients == null || product.ingredients!.isEmpty) {
      return true; // Assume safe if no ingredients listed
    }

    final List<String> lowerCaseIngredients =
    product.ingredients!.map((ingredient) => ingredient.toLowerCase()).toList();

    final List<String> userAllergies = allergyKeys.map((key) {
      switch (key) {
        case 'allergy_arachides': return 'peanuts';
        case 'allergy_amandes': return 'almonds';
        case 'allergy_noix': return 'walnuts';
        case 'allergy_noisettes': return 'hazelnuts';
        case 'allergy_noix_de_cajou': return 'cashews';
        case 'allergy_pistaches': return 'pistachios';
        case 'allergy_noix_de_pecan': return 'pecans';
        case 'allergy_noix_du_bresil': return 'brazil nuts';
        case 'allergy_noix_de_macadamia': return 'macadamia nuts';
        case 'allergy_lait': return 'milk';
        case 'allergy_oeufs': return 'eggs';
        case 'allergy_soja': return 'soy';
        case 'allergy_ble': return 'wheat';
        case 'allergy_poisson': return 'fish';
        case 'allergy_crevettes': return 'shrimp';
        case 'allergy_crabes': return 'crab';
        case 'allergy_homards': return 'lobster';
        case 'allergy_moules': return 'mussels';
        case 'allergy_huitres': return 'oysters';
        case 'allergy_palourdes': return 'clams';
        case 'allergy_sesame': return 'sesame';
        case 'allergy_moutarde': return 'mustard';
        case 'allergy_celeri': return 'celery';
        case 'allergy_lupin': return 'lupin';
        case 'allergy_mais': return 'corn';
        case 'allergy_riz': return 'rice';
        case 'allergy_avoine': return 'oats';
        case 'allergy_orge': return 'barley';
        case 'allergy_seigle': return 'rye';
        case 'allergy_graines_de_tournesol': return 'sunflower seeds';
        case 'allergy_graines_de_citrouille': return 'pumpkin seeds';
        case 'allergy_graines_de_pavot': return 'poppy seeds';
        case 'allergy_cannelle': return 'cinnamon';
        case 'allergy_clou_de_girofle': return 'cloves';
        case 'allergy_levure': return 'yeast';
        case 'allergy_glutamate_monosodique': return 'monosodium glutamate';
        case 'allergy_sulfites': return 'sulfites';
        case 'allergy_tartrazine': return 'tartrazine';
        case 'allergy_benzoates': return 'benzoates';
        case 'allergy_sorbates': return 'sorbates';
        case 'allergy_avocat': return 'avocado';
        case 'allergy_banane': return 'banana';
        case 'allergy_kiwi': return 'kiwi';
        case 'allergy_mangue': return 'mango';
        case 'allergy_noix_de_coco': return 'coconut';
        case 'allergy_huile_de_sesame': return 'sesame oil';
        case 'allergy_huile_d_arachide': return 'peanut oil';
        default: return '';
      }
    }).where((allergy) => allergy.isNotEmpty).toList();

    for (final allergy in userAllergies) {
      if (lowerCaseIngredients.any((ingredient) => ingredient.contains(allergy.toLowerCase()))) {
        return false; // Not safe
      }
    }
    return true; // Safe
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final userPrefs = Provider.of<UserPreferences>(context);

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
        title: Text(localizations.scanQRTitle, style: TextStyle(color: userPrefs.textColor, fontSize: 24)),
        backgroundColor: userPrefs.appBarColor,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(qrText.isEmpty ? localizations.scanQRCode : '${localizations.product}: $qrText',
                      textAlign: TextAlign.center, style: TextStyle(color: userPrefs.textColor, fontSize: 18)),
                  const SizedBox(height: 10),
                  if (_scannedProduct != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${localizations.allergies}: ', style: TextStyle(color: userPrefs.textColor)),
                        Icon(
                          _isSafe == true ? Icons.check_circle : (_isSafe == false ? Icons.warning : Icons.question_mark),
                          color: _isSafe == true ? Colors.green : (_isSafe == false ? Colors.red : Colors.grey),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  if (_scannedProduct != null)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoScreen(productData: _scannedProduct!.toMap()),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: userPrefs.buttonColor,
                        side: BorderSide(color: userPrefs.textColor),
                      ),
                      child: Text(localizations.info, style: TextStyle(color: userPrefs.textColor)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (_isProcessing) return;
      _isProcessing = true;

      final code = scanData.code;
      if (code != null) {
        setState(() {
          qrText = code;
          _scannedProduct = null;
          _isSafe = null;
        });
        await _fetchAndCheckProduct(code);
      }

      _isProcessing = false;
    });
  }

  Future<void> _fetchAndCheckProduct(String barcode) async {
    try {
      final productData = await _openFoodFactsService.getProduct(barcode);
      if (!mounted) return;
      if (productData == null || productData.isEmpty || productData['product'] == null) {
        setState(() {
          _scannedProduct = null;
          _isSafe = null;
          qrText = AppLocalizations.of(context)!.errorContent('Product not found');
        });
        return;
      }

      final product = Product.fromMap(productData);
      final userPrefs = context.read<UserPreferences>();
      final localizations = AppLocalizations.of(context)!;
      final isSafe = _checkAllergies(product, userPrefs.allergies, localizations);

      setState(() {
        _scannedProduct = product;
        _isSafe = isSafe;
      });
    } catch (e) {
      if (!mounted) return;
      final localizations = AppLocalizations.of(context)!;
      final userPrefs = Provider.of<UserPreferences>(context, listen: false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(localizations.errorTitle, style: TextStyle(color: userPrefs.textColor)),
          content: Text(localizations.errorContent(e.toString())),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      setState(() {
        _scannedProduct = null;
        _isSafe = null;
        qrText = localizations.errorTitle;
      });
    }
  }
}