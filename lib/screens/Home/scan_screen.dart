import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:nutri_tracker/providers/user_preferences.dart';
import 'package:nutri_tracker/services/open_food_facts_service.dart';
import 'package:nutri_tracker/screens/Home/info_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? _lastScannedCode;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';
  final OpenFoodFactsService _openFoodFactsService = OpenFoodFactsService();
  bool _isProcessing = false;
  

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
      if (_isProcessing || scanData.code == null) return;

      // Évite de traiter deux fois le même code
      if (scanData.code == _lastScannedCode) return;

      _isProcessing = true;
      _lastScannedCode = scanData.code;

      setState(() {
        qrText = scanData.code!;
      });

      await _fetchAndCheckProduct(scanData.code!);
      _isProcessing = false;
    });
  }


  Future<void> _fetchAndCheckProduct(String barcode) async {
    try {
      final productData = await _openFoodFactsService.getProduct(barcode);
      if (!mounted) return;
      if (productData.isEmpty || productData['product'] == null) {
        setState(() {
          qrText = AppLocalizations.of(context)!.errorContent('Product not found');
        });
        return;
      }

      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen(productData: productData)));
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
        qrText = localizations.errorTitle;
      });
    }
  }
}