import 'package:dhanvanth/chat_sreen.dart';
import 'package:dhanvanth/tunnel_link.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: App());
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  void func() async {
    var options =
        const ScanOptions(android: AndroidOptions(useAutoFocus: true));
    var result = await BarcodeScanner.scan(options: options);
    setState(() {
      Tunnel().tunnelUrl = result.rawContent;
    });
  }

  @override
  void initState() {
    super.initState();
    func();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ChatScreen(),
    );
  }
}
