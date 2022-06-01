// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, must_call_super

import 'package:dhanvanth/parser.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;

Parser p = Parser();

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  final _bot = const types.User(
    id: '06c33e8b-e835-4736-80f4-63f44b8888c',
    firstName: "Dhanvanth",
    lastName: "MedBot",
  );
  List<types.Message> messages = [];

  @override
  void initState() {
    messages.add(types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text:
          "Hi I'm Dhanvanth, your medical assistance\n Try telling me \n1)'What are the symptoms of Jaundice?\n2)I have high fever'",
    ));
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  void _removeMessage() {
    setState(() {
      messages.removeAt(0);
    });
  }

  void callBackend(String statement) async {
    print(p.urlCreate(statement));
    http.Response response = await http.get(Uri.parse(p.urlCreate(statement)));
    if (response.statusCode == 200) {
      print("response received");
      Map<String, dynamic> a = json.decode(response.body);
      p = Parser.getInstance(a);
      _handleReceived(types.PartialText(text: p.message));
    }
  }

  void _handleReceived(types.PartialText message) {
    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    _removeMessage();
    _addMessage(botMessage);
  }

  void _handleSendPressed(types.PartialText message) {
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(userMessage);

    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: "typing...",
    );

    _addMessage(botMessage);
    callBackend(message.text);
  }

  var micset = Colors.red;
  bool isSpeak = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 43, 34, 79),
      child: SafeArea(
        child: Material(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 43, 34, 79),
            appBar: AppBar(
              actions: [
                Expanded(child: SizedBox()),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.speaker,
                      color: micset,
                    ),
                    onPressed: () {
                      if (isSpeak) {
                        setState(() {
                          micset = Colors.red;
                          isSpeak = false;
                        });
                      } else {
                        setState(() {
                          micset = Colors.green;
                          isSpeak = true;
                        });
                      }
                    },
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
              elevation: 10,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 43, 34, 79),
              title: Text("Medical Bot using AI"),
            ),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Chat(
                sendButtonVisibilityMode: SendButtonVisibilityMode.always,
                theme: DarkChatTheme(),
                avatarBuilder: (String) => Image.asset(
                  'assets/dhanvanth.png',
                  scale: 6,
                ),
                showUserAvatars: true,
                showUserNames: true,
                messages: messages,
                onSendPressed: _handleSendPressed,
                user: _user,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
