import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  final String qrData;

  const InfoScreen({super.key, required this.qrData});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String savedData = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Save scanned QR data
  Future<void> _saveData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('qrData', data);
  }

  // Load saved QR data
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedData = prefs.getString('qrData') ?? 'No previous scan';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutritional Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scanned Data: ${widget.qrData}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveData(widget.qrData);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Saved')),
                );
              },
              child: const Text('Save Data'),
            ),
            const SizedBox(height: 20),
            Text('Previously Scanned: $savedData', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
