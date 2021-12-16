import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    late IconData leadingIcon;

    if (type == 'http') {
      leadingIcon = Icons.link;
    } else if (type == 'WIFI') {
      leadingIcon = Icons.wifi_lock_outlined;
    } else if (type == 'geo') {
      leadingIcon = Icons.map;
    } else {
      leadingIcon = Icons.pie_chart;
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: scans.length,
      itemBuilder: (_, i) => Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
            dismissible: DismissiblePane(
              onDismissed: () {
                qrAlert(context, scans[i].value);

                scanListProvider.loadScansByType(type);
              },
            ),
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  qrAlert(context, scans[i].value);
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.qr_code_2_outlined,
                label: 'QR',
              ),
            ]),
        endActionPane: ActionPane(
            dismissible: DismissiblePane(
              onDismissed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteScanById(scans[i].id!);
              },
            ),
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  Provider.of<ScanListProvider>(context, listen: false)
                      .deleteScanById(scans[i].id!);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete_rounded,
                label: 'Delete',
              ),
            ]),
        child: ListTile(
          leading: Icon(leadingIcon, color: Theme.of(context).primaryColor),
          title: Text(
            scans[i].name as String,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Text(
            scans[i].value,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: Icon(Icons.swipe_rounded, color: Colors.grey),
          onTap: () => launchCode(context, scans[i]),
          onLongPress: () {
            print(scans[i].name);
            changeNameAlert(context, leadingIcon, i);
          },
        ),
      ),
    );
  }
}
