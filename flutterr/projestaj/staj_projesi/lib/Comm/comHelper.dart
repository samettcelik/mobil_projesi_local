import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Toast Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Toast Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            alertDialog(context, "Lütfen Kullanıcı ID giriniz.");
          },
          child: Text('Show Toast'),
        ),
      ),
    );
  }
}

void alertDialog(BuildContext context, String msg) {
  ToastContext toastContext = new ToastContext();
  toastContext.init(context);
  Toast.show(msg, duration: Toast.lengthLong, gravity: Toast.bottom);
}

validateEmail(String email){
  final emailReg = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  return emailReg.hasMatch(email);
}