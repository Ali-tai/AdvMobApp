import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
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
  String qrText = 'Scanne un code QR ou un code-barres !';
  final OpenFoodFactsService _openFoodFactsService = OpenFoodFactsService();
  bool _isProcessing = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
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
              child: Text(qrText),
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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: Text(e.toString()),
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
