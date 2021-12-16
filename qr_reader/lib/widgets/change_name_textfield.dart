import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';

class ChangeName extends StatelessWidget {
  final IconData leadingIcon;
  final int i;

  const ChangeName({Key? key, required this.leadingIcon, required this.i})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;

    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return TextField(
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(color: Theme.of(context).primaryColor),
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.go,
      onSubmitted: (value) {
        uiProvider.changeName = value;
        uiProvider.changeNameController.clear();
        Provider.of<ScanListProvider>(context, listen: false)
            .updatedScanById(scans[i], uiProvider.changeName);
        uiProvider.changeName = '';
        Navigator.of(context).pop();
      },
      controller: uiProvider.changeNameController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sizew * 0.03),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(sizew * 0.03)),
        hintText: "Scan's name",
        labelText: 'Name',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: Icon(
          leadingIcon,
          color: Theme.of(context).primaryColor,
        ),
        //icon: Icon(leadingIcon),
      ),
    );
  }
}
