import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: const [
          _AddButton(title: 'Locations', type: 'geo'),
          _AddButton(title: 'Others', type: 'other'),
          _AddButton(title: 'Create a QR Code', type: 'create'),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final String title;
  final String type;

  const _AddButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    late bool _pressed;
    late String _subtitleText;
    if (type == 'geo') {
      _pressed = uiProvider.pressedButton1;
    } else if (type == 'other') {
      _pressed = uiProvider.pressedButton2;
    } else {
      _pressed = uiProvider.pressedButton3;
    }
    if (type == 'geo') {
      _subtitleText = 'Tap to see locations scans';
    } else if (type == 'other') {
      _subtitleText = 'Tap to see others scans ';
    } else {
      _subtitleText = 'Tap to create a QR code ';
    }
    double sizew = MediaQuery.of(context).size.width;
    double sizeh = MediaQuery.of(context).size.height;
    String subtitle = _subtitleText;

    return Column(
      children: [
        InkWell(
          onTap: () {
            if (type == 'geo') {
              uiProvider.pressedButton1 = !_pressed;
              uiProvider.pressedButton2 = false;
              uiProvider.pressedButton3 = false;
            } else if (type == 'other') {
              uiProvider.pressedButton1 = false;
              uiProvider.pressedButton2 = !_pressed;
              uiProvider.pressedButton3 = false;
            } else {
              uiProvider.pressedButton1 = false;
              uiProvider.pressedButton2 = false;
              uiProvider.pressedButton3 = !_pressed;
            }
          },
          child: SizedBox(
            width: double.infinity,
            height: sizeh * 0.08,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(sizew * 0.045),
                  height: double.infinity,
                  width: sizew * 0.15,
                  child: ElevatedButton(
                    child: Icon(
                      _pressed ? Icons.remove : Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      shape: const CircleBorder(),
                      padding: EdgeInsets.only(right: sizew * 0.02),
                      primary: Colors.transparent, // <-- Button color
                      onPrimary:
                          Theme.of(context).primaryColor, // <-- Splash color
                    ),
                    onPressed: () {
                      if (type == 'geo') {
                        uiProvider.pressedButton1 = !_pressed;
                        uiProvider.pressedButton2 = false;
                        uiProvider.pressedButton3 = false;
                      } else if (type == 'other') {
                        uiProvider.pressedButton1 = false;
                        uiProvider.pressedButton2 = !_pressed;
                        uiProvider.pressedButton3 = false;
                      } else {
                        uiProvider.pressedButton1 = false;
                        uiProvider.pressedButton2 = false;
                        uiProvider.pressedButton3 = !_pressed;
                      }
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: TextStyle(fontSize: sizew * 0.05)),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: sizew * 0.03, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ),
        _pressed ? _ReturnPages(type: type) : Container(),
      ],
    );
  }
}

class _ReturnPages extends StatelessWidget {
  final String type;

  const _ReturnPages({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (type) {
      case 'geo':
        scanListProvider.loadScansByType('geo');
        return const MapsPage();
      case 'other':
        scanListProvider.loadScansByType('other');
        return OthersPage();
      case 'create':
        return const CreateQRPage();

      default:
        return const CreateQRPage();
    }
  }
}
