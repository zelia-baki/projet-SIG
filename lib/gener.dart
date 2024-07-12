import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

void main() {
  runApp(Gener());
}

class Gener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QRCodePage(),
    );
  }
}

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final TextEditingController _controller = TextEditingController();
  String? _qrData;

  Future<void> _fetchQRCode(int id) async {
    final response = await http.get(Uri.parse('http://0.0.0.0:5000/qr/$id'));

    if (response.statusCode == 200) {
      setState(() {
        _qrData = jsonDecode(response.body)['data'];
      });
    } else {
      setState(() {
        _qrData = null;
      });
      throw Exception('Le QR code ne s affiche pas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte Visite QR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Inserer l'indentifiant de la carte",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final id = int.tryParse(_controller.text);
                if (id != null) {
                  _fetchQRCode(id);
                }
              },
              child: Text('Obtenir le QR code'),
            ),
            SizedBox(height: 20),
            _qrData != null
                ? QrImage(
                    data: _qrData!,
                    version: QrVersions.auto,
                    size: 200.0,
                  )
                : Text("Insérer l'identifiant pour générer le qr code"),
          ],
        ),
      ),
    );
  }
}
