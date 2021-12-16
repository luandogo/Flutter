import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/widgets/widgets.dart';

class OthersPage extends StatelessWidget {
  const OthersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    if (scans.isEmpty) {
      return Center(
          child: Text(
        'No codes scanned',
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
      ));
    } else {
      return const ScanTiles(type: 'other');
    }
  }
}
