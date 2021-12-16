import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: UniqueKey(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('QR Reader'),
          actions: [
            IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: () {
                  Provider.of<ScanListProvider>(context, listen: false)
                      .deleteAll();
                })
          ],
        ),
        body: _HomePageBody(),

        // CustomScrollView(
        //   slivers: [
        //     const CustomAppBar(title: 'QR Scanner'),
        //     SliverList(delegate: SliverChildListDelegate([_HomePageBody()]))
        //   ],
        // ),
        bottomNavigationBar: CustomNavigationBar(),
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtain the selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // Change to show the respective page
    final currenIndex = uiProvider.selectedMenuOpt;

    DBProvider.db.database;

    // Use ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    switch (currenIndex) {
      case 0:
        scanListProvider.loadScansByType('http');
        return WebsitesPage();
      case 1:
        scanListProvider.loadScansByType('WIFI');
        return WiFiPage();
      case 2:
        return const MorePage();

      default:
        return WebsitesPage();
    }
  }
}
