import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  IO.Socket? socket;
  SocketService._internal();
  Function(dynamic data)? onLoginEvent;
  Function(dynamic data)? onLogoutEvent;
  factory SocketService() {
    return _instance;
  }

  void connectAndListen() {
    socket ??= IO.io('http://localhost:3500',
        IO.OptionBuilder().setTransports(['websocket']).build());
    print('sssss');
    try {
      socket!.onConnect((data) => {
            print('connected to server'),
          });
    } catch (e) {
      print(e);
    }

    socket!.on('session-expired', (data) {
      onLogoutEvent?.call(data);
    });

    socket!.on('session-join', (data) {
      onLoginEvent?.call(data);
    });
  }

  void joinSession(String userID) {
    socket!.emit("user-join", userID);
  }
}
