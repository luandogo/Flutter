import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:band_names/src/models/models.dart';
import 'package:band_names/src/services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands);
    super.initState();
  }

  _handleActiveBands(dynamic payload) {
    bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title:const Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: socketService.serverStatus == ServerStatus.Online
                  ? Icon(Icons.check_circle, color: Colors.green[300])
                  : const Icon(Icons.offline_bolt, color: Colors.red))
        ],
      ),
      body: Column(
        children: [
          _ShowGraph(bands: bands),
          Expanded(
            child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (BuildContext context, int index) =>
                    _BandTile(band: bands[index])),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('New Band Name: '),
                content: TextField(controller: textController),
                actions: [
                  MaterialButton(
                      child:const  Text('Add'),
                      elevation: 5,
                      textColor: Colors.blue,
                      onPressed: () => addBandToList(textController.text))
                ],
              ));
    }
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text('New Band Name: '),
              content: CupertinoTextField(controller: textController),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text('Add'),
                    onPressed: () => addBandToList(textController.text)),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: const Text('Dismiss'),
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  }
}

class _BandTile extends StatelessWidget {
  const _BandTile({
    Key? key,
    required this.band,
  }) : super(key: key);

  final Band band;

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => socketService.emit('delete-band', {'id': band.id}),
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete Band',
              style: TextStyle(color: Colors.white),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => socketService.socket.emit('vote-band', {'id': band.id}),
      ),
    );
  }
}

class _ShowGraph extends StatelessWidget {
  final List<Band> bands;
  const _ShowGraph({Key? key, required this.bands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Map<String, double> dataMap = {
    //   "Flutter": 5,
    //   "React": 3,
    //   "Xamarin": 2,
    //   "Ionic": 2,
    // };
    Map<String, double> dataMap = Map();
    for (var band in bands) {
      dataMap.putIfAbsent(band.name, () => band.votes!.toDouble());
    }

    final List<Color> colorList = [
      Colors.teal,
      Colors.red,
      Colors.cyan,
      Colors.pink,
      Colors.yellow,
      Colors.green,
    ];
    return dataMap.isNotEmpty
        ? Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 200.0,
            child: PieChart(
              dataMap: dataMap,
              animationDuration:const  Duration(milliseconds: 800),
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                  decimalPlaces: 0,
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  chartValueStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          )
        : const LinearProgressIndicator();
  }
}
