import 'dart:math';

import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';

import 'InputScreen.dart';

void main() {
  // List<String> uniqueIds = generateUniqueIds(100);
  // print(uniqueIds);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: InputScreen(),
    );
  }
}

List<String> generateUniqueIds(int count) {
  List<String> ids = [];
  Random random = Random();

  for (int i = 0; i < count; i++) {
    String id = '';
    // Generate a random 6-character alphanumeric ID
    for (int j = 0; j < 2; j++) {
      int randomNumber = random.nextInt(36);
      if (randomNumber < 26) {
        // Add a random letter (A-Z)
        id += String.fromCharCode('A'.codeUnitAt(0) + randomNumber);
      } else {
        // Add a random number (0-9)
        id += (randomNumber - 26).toString();
      }
    }
    ids.add(id);
  }

  return ids;
}

