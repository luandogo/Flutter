import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currenIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
      elevation: 0,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: (int index) => uiProvider.selectedMenuOpt = index,
      currentIndex: currenIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Web'),
        BottomNavigationBarItem(
            icon: Icon(Icons.signal_wifi_4_bar_lock), label: 'Wi-Fi'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
      ],
    );
  }
}
