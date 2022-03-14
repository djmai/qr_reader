import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        // Datos de prueba
        // final barcodeScanRes = 'https://www.eltresm.com.mx';
        // final barcodeScanRes = 'geo:21.170247,-101.9307827';

        final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        final scanListProvider = Provider.of<ScanListProvider>(
          context,
          listen: false,
        );

        if (barcodeScanRes == '-1') return;

        await scanListProvider
            .nuevoScan(barcodeScanRes)
            .then((scan) => launchURL(context, scan));
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
