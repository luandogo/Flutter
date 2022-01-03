import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinteresButton {
  final Function onPressed;
  final IconData icon;

  PinteresButton({required this.onPressed, required this.icon});
}

class PinterestMenu extends StatelessWidget {
  final bool show;
  final List<PinteresButton> items;

  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;

  const PinterestMenu(
      {Key? key,
      this.show = true,
      required this.items,
      this.backgroundColor = Colors.white,
      this.selectedColor = Colors.red,
      this.unselectedColor = Colors.blueGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: (show) ? 1 : 0,
          child: Builder(builder: (BuildContext context) {
            Provider.of<_MenuModel>(context).backgroundColor =
                backgroundColor ?? Colors.white;
            Provider.of<_MenuModel>(context).selectedColor =
                selectedColor ?? Colors.red;
            Provider.of<_MenuModel>(context).unselectedColor =
                unselectedColor ?? Colors.blueGrey;
            return _PinterestMenuBackground(
                child: _MenuItems(menuItems: items));
          })),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget? child;
  const _PinterestMenuBackground({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;
    return Container(
      child: child ?? Container(),
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5)
          ]),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinteresButton> menuItems;

  const _MenuItems({Key? key, required this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (index) => _PinterestMenuButton(index: index, item: menuItems[index]),
      ),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinteresButton item;
  const _PinterestMenuButton(
      {Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedItem = Provider.of<_MenuModel>(context).selectedItem;
    final selectedColor = Provider.of<_MenuModel>(context).selectedColor;
    final unselectedColor = Provider.of<_MenuModel>(context).unselectedColor;
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).selectedItem = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Icon(
        item.icon,
        size: (selectedItem == index) ? 35 : 25,
        color: (selectedItem == index) ? selectedColor : unselectedColor,
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _selectedItem = 0;
  int get selectedItem => _selectedItem;
  set selectedItem(int index) {
    _selectedItem = index;
    notifyListeners();
  }

  Color backgroundColor = Colors.white;

  Color selectedColor = Colors.red;

  Color unselectedColor = Colors.blueGrey;
}
