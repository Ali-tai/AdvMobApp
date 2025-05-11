import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/user_preferences.dart';
import '../services/open_food_facts_service.dart';
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
  final OpenFoodFactsService _openFoodFactsService = OpenFoodFactsService();
  bool _isProcessing = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final userPrefs = Provider.of<UserPreferences>(context);

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
          title: Text(localizations.scanQRTitle, style: TextStyle(color: userPrefs.textColor, fontSize: 24)),
          backgroundColor: userPrefs.appBarColor
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
            flex: 1,
            child: Center(
              child: Text(qrText.isEmpty ? localizations.scanQRCode : qrText, style: TextStyle(color: userPrefs.textColor, fontSize: 20)),
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
        });
        await _fetchProductData(code);
      }

      _isProcessing = false;
    });
  }

  Future<void> _fetchProductData(String barcode) async {
    try {
      final productData = await _openFoodFactsService.getProduct(barcode);
      if (!mounted) return;
      if (productData == null || productData.isEmpty || productData['product'] == null) return;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoScreen(productData: productData),
        ),
      );

      _isProcessing = false;
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
      _isProcessing = false;
    }
  }
}
