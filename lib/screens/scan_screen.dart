import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/user_preferences.dart';
import '../services/open_food_facts_service.dart';
import '../providers/product.dart'; // Import the Product model
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
  bool? _isSafe; // Nullable boolean to represent the allergy safety
  final OpenFoodFactsService _openFoodFactsService = OpenFoodFactsService();
  bool _isProcessing = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool _checkAllergies(Product product, List<String> allergies) {
    // This is a simplified check. Adapt based on your product data structure.
    final ingredients = product.name.toLowerCase(); // Placeholder: Replace with actual ingredient list access
    for (final allergy in allergies) {
      if (ingredients.contains(allergy.toLowerCase())) {
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
                  Text(qrText.isEmpty ? localizations.scanQRCode : localizations.product + ': $qrText',
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
          _scannedProduct = null; // Reset previous product
          _isSafe = null; // Reset previous safety status
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
      final userAllergies = Provider.of<UserPreferences>(context, listen: false).allergies;
      final isSafe = _checkAllergies(product, userAllergies);

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