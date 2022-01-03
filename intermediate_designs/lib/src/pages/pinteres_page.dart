import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intermediate_designs/src/widgets/drawer_animation.dart';
import 'package:intermediate_designs/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: DrawerAnimation(
        child: Scaffold(
          body: Stack(
            children: const [PinterestGrid(), _PinterestMenuLocation()],
          ),
          //body: PinterestGrid(),
          //body: PinterestMenu(),
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final show = Provider.of<_MenuModel>(context).show;
    return Positioned(
        bottom: 30,
        child: SizedBox(
          width: width,
          child: Align(
            child: PinterestMenu(
              show: show,
              items: [
                PinteresButton(
                    onPressed: show
                        ? () {
                            print('Icon pie_chart');
                          }
                        : () {},
                    icon: Icons.pie_chart),
                PinteresButton(
                    onPressed: show
                        ? () {
                            print('Icon search');
                          }
                        : () {},
                    icon: Icons.search),
                PinteresButton(
                    onPressed: show
                        ? () {
                            print('Icon notifications');
                          }
                        : () {},
                    icon: Icons.notifications),
                PinteresButton(
                    onPressed: show
                        ? () {
                            print('Icon supervised_user_circle');
                          }
                        : () {},
                    icon: Icons.supervised_user_circle),
              ],
            ),
          ),
        ));
  }
}

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({Key? key}) : super(key: key);

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (index) => index);
  ScrollController controller = ScrollController();
  double previousScroll = 0;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > previousScroll && controller.offset > 100) {
        Provider.of<_MenuModel>(context, listen: false).show = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).show = true;
      }
      previousScroll = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        pattern: const [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _PinterestItem(index: index),
          childCount: items.length),
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;
  bool get show => _show;
  set show(bool value) {
    _show = value;
    notifyListeners();
  }
}
