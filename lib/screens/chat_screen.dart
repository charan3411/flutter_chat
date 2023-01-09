import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/widgets/chat/messages.dart';
import 'package:flutter_chat/widgets/chat/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState () {
    // final fbm = FirebaseMessaging.instance;
    // fbm.requestPermission();
    // FirebaseMessaging.onMessage.listen((msg) {
    //   print(msg);
    //   return;
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print("onMessageOpenedApp: $message");
    // });
    //
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   print("onBackgroundMessage: $message");
    // });
    FirebaseMessaging.instance.getToken().then((token) {
      print("Token: $token");
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),

    );
  }
}