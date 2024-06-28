import 'package:book_ticket/zoomzbleWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  int rows = 0;
  int columns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Rows and Columns'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter number of rows',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of rows';
                    }
                    int? parsedValue = int.tryParse(value);
                    if (parsedValue == null || parsedValue <= 0 || parsedValue > 26) {
                      return 'Rows should be between 1 and 26';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    rows = int.tryParse(value!) ?? 0;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter number of columns',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of columns';
                    }
                    int? parsedValue = int.tryParse(value);
                    if (parsedValue == null || parsedValue <= 0) {
                      return 'Columns should be a positive number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    columns = int.tryParse(value!) ?? 0;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Navigate to the next screen or perform any action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ZoomableList(row: rows, clm: columns),
                        ),
                      );
                    } else {
                      // Show validation errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fix the errors in the form.'),
                        ),
                      );
                    }
                  },
                  child: Text('Proceed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}