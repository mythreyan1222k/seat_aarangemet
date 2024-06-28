import 'package:book_ticket/GetterSetters.dart';
import 'package:book_ticket/markSelectedSeats.dart';
import 'package:book_ticket/utils.dart';
import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';

import 'InputScreen.dart';
import 'MarkOccupiedSeats.dart';

class selectNumberOfSeat extends StatefulWidget {

   selectNumberOfSeat({super.key,});

  @override
  State<selectNumberOfSeat> createState() => _selectNumberOfSeatState();
}

class _selectNumberOfSeatState extends State<selectNumberOfSeat> {
  int? seats;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   /* return Scaffold(
      body: Center(child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter number of columns',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter number of seats';
              }

              return null;
            },
            onChanged: (value) {
              print(value);
              setState(() {
                seats = int.tryParse(value) ?? 0;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
             GetterSetters.instances.setseatcount=seats!;
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZoomableList(occupiedSeat: widget.occupiedSeat,),
              ),
            );
            },
            child: Text('Proceed'),
          ),
        ],
      ),),
    );*/

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
                      Text("For Booking",style: TextStyle(
                          fontSize: 30,fontWeight: FontWeight.bold,
                          color: Colors.white,letterSpacing: 2.0),),
                      Text("Enter Number Of Seats",style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold,
                          color: Colors.white,letterSpacing: 2.0),),
                      Spacer(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          // labelText: 'Enter number of rows',
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Number of seats',
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
                            return 'Please enter number of seats';
                          }
                          int? parsedValue = int.tryParse(value);
                          if (parsedValue == null || parsedValue <= 0 || parsedValue > 26) {
                            return 'Rows should be between 1 and 26';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          seats = int.tryParse(value!) ?? 0;
                        },
                      ),
                      SizedBox(height: 50.0),
                      SubmitButton(name: "Proceed",ontap: (){
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Navigate to the next screen or perform any action
                          GetterSetters.instances.setseatcount=seats!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarkSelectedSeats(),
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
                      SizedBox(height: 150.0),

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
