import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => _serverStatus;
  late IO.Socket _socket;
  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    const String localhost = 'http://192.168.1.64:3000/';
    // Dart client
    _socket = IO.io(
        localhost,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect() // optional
            .build());
    _socket.onConnect((data) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.onDisconnect((data) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('new-message', (payload) {
    //   print('New Message: $payload');
    //   print(payload.containsKey('message2') ? payload['message2'] : 'Null');
    // });
  }
}
