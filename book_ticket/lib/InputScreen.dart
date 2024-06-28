import 'package:book_ticket/GetterSetters.dart';
import 'package:book_ticket/utils.dart';
import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MarkOccupiedSeats.dart';

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
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Utils.darkBaseColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(children: [
          Align(alignment: Alignment.topCenter,
            child: Container(
              height: size.height/1.7,
              width: size.width,
              child: Image(image: AssetImage('assets/landingImage.png'),fit: BoxFit.cover,),
            ),
          ),
          Align(alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height/1.7,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops:[0.0,0.2],
                    colors: [
                      Utils.darkBaseColor.withOpacity(0.01),
                      Utils.darkBaseColor
                    ])
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Spacer(),
                      Text("Calculates",style: TextStyle(
                          fontSize: 30,fontWeight: FontWeight.bold,
                          color: Colors.white,letterSpacing: 2.0),),
                      Text("Total Number Of Seats",style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold,
                          color: Colors.white,letterSpacing: 2.0),),Spacer(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          // labelText: 'Enter number of rows',
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Number of rows',
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10.7),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10.7),
                          ),
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
                        autofocus: false,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          // labelText: 'Enter number of rows',
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Number of columns',
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10.7),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10.7),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of columns';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          columns = int.tryParse(value!) ?? 0;
                        },
                      ),
                      SizedBox(height: 20.0),
                      SubmitButton(name: "Proceed",ontap: (){
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Navigate to the next screen or perform any action
                          GetterSetters.instances.setclm=columns;
                          GetterSetters.instances.setrow=rows;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarkOccupiedSeats(),
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
                      },),
                      SizedBox(height: 50.0),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],),

      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  String name;
  Function ontap;
  bool? oultine;
   SubmitButton({super.key,required this.name,required this.ontap,this.oultine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ontap();},
      child: Container(
        height: 40,
        width: double.maxFinite,
        decoration:oultine==true?BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.7)),
          border: Border.all(color: Utils.btnclr1)
        ) : BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops:[0.0,0.2],
                colors: [
                  Utils.btnclr2,
                  Utils.btnclr1
                ]),
          borderRadius: BorderRadius.all(Radius.circular(10.7))
        ),
        child: Center(child: Text(name??"",style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}
