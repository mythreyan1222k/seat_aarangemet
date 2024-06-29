import 'dart:math';

import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';
import 'InputScreen.dart';

void main() {
  // List<String> uniqueIds = generateUniqueIds(100);
  // print(uniqueIds);
  runApp( MyApp());

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




class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Table Cell Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TablePage(),
    );
  }
}


class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  List<List<String>> tableData = [];
  List<int> selectedCells = [];

  void generateTable() {
    int numRows = 20;
    int numCols = 10;
    List<List<String>> data = [];

    for (int i = 0; i < numRows; i++) {
      List<String> row = [];
      for (int j = 0; j < numCols; j++) {
        String label = String.fromCharCode(65 + i) + (j + 1).toString();
        row.add(label);
      }
      data.add(row);
    }

    setState(() {
      tableData = data;
      selectedCells = [];
    });
  }

  void selectCells(int index) {
    setState(() {
      selectedCells.clear();
      for (int i = 0; i < 4; i++) {
        int currentCellIndex = index + i;
        if (currentCellIndex < 200) { // 20 rows * 10 columns
          selectedCells.add(currentCellIndex);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Table Cell Selection'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: generateTable,
            child: Text('Generate Table'),
          ),
          Expanded(
            child: tableData.isEmpty
                ? Center(child: Text('Press "Generate Table" to create table'))
                : SingleChildScrollView(
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: tableData.map((row) {
                  int rowIndex = tableData.indexOf(row);
                  return TableRow(
                    children: row.map((cell) {
                      int cellIndex = rowIndex * 10 + row.indexOf(cell);
                      bool isSelected = selectedCells.contains(cellIndex);
                      return GestureDetector(
                        onTap: () => selectCells(cellIndex),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: isSelected ? Colors.lightGreen : null,
                          child: Center(child: Text(cell)),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}