import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppState();
  }

}

class AppState extends State<MyApp> {

  FlutterLocalNotificationsPlugin fnp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnp=new FlutterLocalNotificationsPlugin();
    var android=new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS=new IOSInitializationSettings();
    var initSettings=new InitializationSettings(android, IOS);
    fnp.initialize(initSettings,onSelectNotification: onSelectNot);
  }
  Future onSelectNot(String payload) async{
    debugPrint("payload : $payload");
    showDialog(context:context,builder: (_){
      return new AlertDialog(
      title: Text("Notification"),
      content:  new Text("payload : $payload"),
    );
    } );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        title: Text("Flutter Notification"),
      ),
        body: Center(
          child: RaisedButton(onPressed: showNot,child: Text("Notification"),),
        ),


      ),
    );
  }

  Future showNot() async {
    var android= new AndroidNotificationDetails("Channel ID", "Name", "Description",importance: Importance.Max,priority: Priority.High);
    var ios=new IOSNotificationDetails();
    var platform=new NotificationDetails(android, ios);
    await fnp.show(0, 'You got the notification', "Flutter Notification", platform,payload: "Ajay Velhal");
  }
}