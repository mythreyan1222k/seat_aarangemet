import 'dart:math';

import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';
import 'InputScreen.dart';

void main() {

  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: InputScreen(),
    );
  }
}