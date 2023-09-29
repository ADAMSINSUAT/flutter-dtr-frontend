import 'dart:async';

import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final int initialCountdown; // Initial countdown value
  final String message;
  const CountdownWidget(
      {super.key, required this.initialCountdown, required this.message});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late int countdown; // Current countdown value
  late String message; //Passed messaage
  late Timer timer;

  @override
  void initState() {
    super.initState();
    countdown =
        widget.initialCountdown; // Initialize countdown to the initial value
    message = widget.message; //Initialize message to the passed value
    startCountdown(); // Start the countdown when the widget is initialized
  }

  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel(); // Stop the countdown when it reaches zero
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${message} \n Redirecting you to homepage in ${countdown} seconds...', // Display the current countdown value
      textAlign: TextAlign.center,
    );
  }
}
