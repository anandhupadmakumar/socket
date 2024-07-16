import 'package:app/socket_services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var socketService = SocketService();
  var socketMessage = '';

  @override
  void initState() {
    socketService.connectAndListen();
    socketService.onLoginEvent = (data) => {print(data)};
    socketService.onLogoutEvent = (data) => {print(data)};
    socketService.joinSession('anandhu');
    print('stop');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
