import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:localizacionversion2/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String respuesta = '';
  @override
  @override
  Widget build(BuildContext context) {
    //  final productoService = Provider.of(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: 15, left: MediaQuery.of(context).size.width * 0.45),
            child: FloatingActionButton(
              onPressed: () async {
                var barcodeScanRes = await BarcodeScanner.scan();
                respuesta = (barcodeScanRes.rawContent);
                print(respuesta);
              },
              child: const Icon(Icons.qr_code_scanner),
            ),
          ),
        ],
      ),
    );
  }
}
