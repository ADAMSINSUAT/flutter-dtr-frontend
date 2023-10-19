import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_dtr_prototype/ui/countdown_widget.dart';
import 'dart:developer' as devtools show log;

import '../constants/routes.dart';

showAlertDialog(
    BuildContext context, String title, String message, String route) {
  int count = 0;

  if (title.contains("Error")) {
    count = 5;
  } else {
    count = 3;
  }


  AlertDialog alert = AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: title.contains("Connection Error")
              ? <Widget>[
                  Text(message, textAlign: TextAlign.center),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"))
                ]
              : <Widget>[
                  title == "Login Error"
                      ? Column(children: [
                          Text(message, textAlign: TextAlign.center),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Ok"))
                        ])
                      : title == "Server Unreachable"
                          ? Column(
                              children: [
                                Text(message, textAlign: TextAlign.center),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Ok"))
                              ],
                            )
                          : CountdownWidget(
                              initialCountdown: count, message: message),
                ],
        ),
      ));

  showDialog(
      context: context,
      barrierDismissible:  false,
      builder: (BuildContext context) {
        if (title == "Login") {
          Future.delayed(Duration(seconds: count), () {
            Navigator.of(context).pop(true);
          }).then((_) => Navigator.of(context)
              .pushNamedAndRemoveUntil(route, (route) => false));
        }
        return alert;
      });
}
