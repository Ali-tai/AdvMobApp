import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../widgets/bottom_nav_bar.dart';
import 'info_screen.dart'; // Navigate to InfoScreen after scanning
import 'dart:io';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Scan'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [

              Padding(padding: EdgeInsets.only(top: 60, bottom: 400)),
              ElevatedButton(
                  onPressed: () => {Navigator.push(context,MaterialPageRoute(builder: (context) => const InfoScreen(qrData: '')))},
                  child: Text(''),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    padding: MaterialStatePropertyAll(EdgeInsets.only(top: 50, bottom: 50, left: 60, right: 60)),
                    side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
                  )
              )
            ]
          )
        ),
    );
    throw UnimplementedError();
  }
}





/*
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  bool _isPaused = false;
  QRScannerPlusController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRScannerPlusController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!_isPaused) {
        _isPaused = true;
        controller.pauseCamera();
        setState(() {
          result = scanData;
        });
        // Navigate to InfoScreen with scanned data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoScreen(qrData: scanData.code),
          ),
        );
      }
    });
  }

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
        children: [
          Expanded(
            flex: 4,
            child: QRScannerPlus(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : const Text('Scan a code'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}*/