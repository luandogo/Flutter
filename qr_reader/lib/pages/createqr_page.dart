import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/utils/utils.dart';

class CreateQRPage extends StatelessWidget {
  const CreateQRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final uiProvider = Provider.of<UiProvider>(context);
    final qrText = uiProvider.createQR;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                qrAlert(context, qrText);
              },
              child: QrImage(
                  foregroundColor: Theme.of(context).primaryColor,
                  data: qrText,
                  size: sizew * 0.6,
                  embeddedImage: const AssetImage('assets/chikollo.png'),
                  backgroundColor: Colors.transparent),
            ),

            // SizedBox(height: sizew * 0.08),
            Padding(
              padding: EdgeInsets.all(sizew * 0.05),
              child: _BuildTextField(),
            ),
            Padding(
              padding: EdgeInsets.only(right: sizew * 0.05),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    child: Text("Clear".toUpperCase(),
                        style: TextStyle(fontSize: sizew * 0.05)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(sizew * 0.03)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(sizew * 0.02),
                                    side: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor)))),
                    onPressed: () {
                      uiProvider.createQR = '';
                      uiProvider.clearController.clear();
                    }),
                SizedBox(width: sizew * 0.05),
                ElevatedButton(
                    child: Text("Save".toUpperCase(),
                        style: TextStyle(fontSize: sizew * 0.05)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(sizew * 0.03)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(sizew * 0.02),
                                    side: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor)))),
                    onPressed: () async {
                      String qrTextSave = uiProvider.createQR;
                      final scanListProvider =
                          Provider.of<ScanListProvider>(context, listen: false);
                      final newScan =
                          await scanListProvider.newScan(qrTextSave);
                      uiProvider.createQR = '';
                      uiProvider.clearController.clear();
                      launchCode(context, newScan);
                    }),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return TextField(
      controller: uiProvider.clearController,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      onChanged: (value) {
        uiProvider.createQR = value;
      },
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          hintText: 'Enter the data',
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
    );
  }
}
