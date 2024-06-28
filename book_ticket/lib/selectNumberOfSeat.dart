import 'package:book_ticket/zoomzbleWidget.dart';
import 'package:flutter/material.dart';

class selectNumberOfSeat extends StatefulWidget {
  final int row;
  final int clm;
  List<Seat>? occupiedSeat;
   selectNumberOfSeat({super.key,required this.clm,required this.row,this.occupiedSeat});

  @override
  State<selectNumberOfSeat> createState() => _selectNumberOfSeatState();
}

class _selectNumberOfSeatState extends State<selectNumberOfSeat> {
  int? seats;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              print(seats);
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZoomableList(row: widget.row,
                  clm: widget.clm,seatCount: seats,occupiedSeat: widget.occupiedSeat,),
              ),
            );
            },
            child: Text('Proceed'),
          ),
        ],
      ),),
    );
  }
}
