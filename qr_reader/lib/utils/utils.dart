import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/widgets/widgets.dart';

//import 'package:flutter_wifi_connect/flutter_wifi_connect.dart';

void launchCode(BuildContext context, ScanModel scan) async {
  final value = scan.value;
  final uiProvider = Provider.of<UiProvider>(context, listen: false);

  if (scan.type == 'http') {
    if (await canLaunch(value)) {
      await launch(value);
    } else {
      throw 'Could not launch $value';
    }

    uiProvider.selectedMenuOpt = 0;
  } else if (scan.type == 'geo') {
    Navigator.pushNamed(context, 'map', arguments: scan);
    uiProvider.selectedMenuOpt = 2;
    uiProvider.pressedButton1 = true;
    uiProvider.pressedButton2 = false;
    uiProvider.pressedButton3 = false;
  } else if (scan.type == 'WIFI') {
    final double sizew = MediaQuery.of(context).size.width;

    List<String> stph = getSTPH(value);
    String s = stph[0];
    String t = stph[1];
    String p = stph[2];
    String h = stph[3];

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizew * 0.05)),
            //title: Text('Titulo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Wi-Fi',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: sizew * 0.08,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: sizew * 0.05,
                ),
                Text('SSID:',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: sizew * 0.06,
                        fontWeight: FontWeight.bold)),
                SelectableText(s,
                    style: TextStyle(
                      fontSize: sizew * 0.06,
                    ),
                    maxLines: 1),
                SizedBox(
                  height: sizew * 0.05,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PASSWORD:',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: sizew * 0.06,
                                fontWeight: FontWeight.bold)),
                        SelectableText(p,
                            style: TextStyle(
                              fontSize: sizew * 0.06,
                            ),
                            maxLines: 1),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: p));
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.copy,
                            color: Theme.of(context).hintColor))
                  ],
                ),
                SizedBox(
                  height: sizew * 0.05,
                ),
                Row(
                  children: [
                    Text(
                      'AUTHENTICATION TYPE: ',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: sizew * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      t,
                      style: TextStyle(fontSize: sizew * 0.03),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'HIDDEN: ',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: sizew * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (() {
                        if (h == 'true') {
                          return 'YES';
                        } else {
                          return 'NO';
                        }
                      }()),
                      style: TextStyle(fontSize: sizew * 0.03),
                    ),
                  ],
                )
              ],
            ),
          );
        });
    uiProvider.selectedMenuOpt = 1;
  } else {
    final double sizew = MediaQuery.of(context).size.width;

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizew * 0.05)),
            //title: Text('Titulo'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('QR CODE INFORMATION',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: sizew * 0.06,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: sizew * 0.05,
                  ),
                  SelectableText(
                    value,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: sizew * 0.06,
                    ),
                  ),
                  SizedBox(
                    height: sizew * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: Text("Copy".toUpperCase(),
                            style: TextStyle(fontSize: sizew * 0.05)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(sizew * 0.03)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(sizew * 0.02),
                                    side: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor)))),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: value));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    uiProvider.selectedMenuOpt = 2;
    uiProvider.pressedButton2 = false;
    uiProvider.pressedButton2 = true;
    uiProvider.pressedButton3 = false;
  }
}

List<String> getSTPH(String wifi) {
  String subWiFi = wifi.substring(5);
  List<String> listSTPH = subWiFi.split(';');
  String s = '';
  String t = '';
  String p = '';
  String h = '';

  for (int i = 0; i < listSTPH.length; i++) {
    if (listSTPH[i].contains('S:')) {
      s = listSTPH[i].substring(2);
    } else if (listSTPH[i].contains('P:')) {
      p = listSTPH[i].substring(2);
    } else if (listSTPH[i].contains('T:')) {
      t = listSTPH[i].substring(2);
    } else if (listSTPH[i].contains('H:')) {
      h = listSTPH[i].substring(2);
    }
  }
  List<String> stph = [s, t, p, h];
  return stph;
}

void changeNameAlert(BuildContext context, IconData leadingIcon, int i) {
  final double sizew = MediaQuery.of(context).size.width;
  final uiProvider = Provider.of<UiProvider>(context, listen: false);
  final scanListProvider =
      Provider.of<ScanListProvider>(context, listen: false);
  final scans = scanListProvider.scans;
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sizew * 0.05)),
          title: const Text('Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Change the scan's name"),
              SizedBox(height: sizew * 0.06),
              ChangeName(
                leadingIcon: leadingIcon,
                i: i,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar')),
            TextButton(
                onPressed: () {
                  uiProvider.changeName = uiProvider.changeNameController.text;
                  uiProvider.changeNameController.clear();
                  Provider.of<ScanListProvider>(context, listen: false)
                      .updatedScanById(scans[i], uiProvider.changeName);
                  uiProvider.changeName = '';

                  Navigator.of(context).pop();
                },
                child: const Text('Ok'))
          ],
        );
      });
}

qrAlert(BuildContext context, String qrValue) {
  final double sizew = MediaQuery.of(context).size.width;

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sizew * 0.05)),
          //title: Text('Titulo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: sizew * 0.7,
                height: sizew * 0.7,
                child: QrImage(
                  embeddedImage: const AssetImage('assets/chikollo.png'),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).primaryColor,
                  errorStateBuilder: (context, error) => Text(error.toString()),
                  data: qrValue,
                ),
              ),
            ],
          ),
        );
      });
}
