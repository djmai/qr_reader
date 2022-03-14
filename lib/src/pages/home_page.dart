import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';

// Paginas
import 'package:qr_reader/src/pages/direcciones_page.dart';
import 'package:qr_reader/src/pages/mapas_page.dart';

// Widgets
import 'package:qr_reader/src/widgets/custom_navigationbar.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';
import 'package:qr_reader/src/widgets/scan_tiles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .borrarTodos();
            },
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // ! TODO: Temporal leer la bd
    // DBProvider.db.database;
    // ! Insertar dato en la DB
    // final tempScan = new ScanModel(valor: 'http://google.com');
    // DBProvider.db.nuevoScan(tempScan);
    // ! Consultar ID en la DB
    // DBProvider.db.getScanById(3).then((scan) => print(scan?.valor));
    // ! Todos los scans
    // DBProvider.db.getScans().then(print);
    // ! Eliminar base de datos
    // DBProvider.db.deleteAllScans().then(print);

    // Usar ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      // return ScanTiles(tipo: 'geo');
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
