import 'package:book_ticket/utils.dart';
import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';

import 'GetterSetters.dart';

class TicketWidget extends StatefulWidget {
  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  List<Seat> selectedSeats=[];

  @override
  void initState() {
    // TODO: implement initState
    selectedSeats=GetterSetters.instances.selectedSeat;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          color: Colors.white,
          // padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                color: Utils.btnclr2,
                child: Center(child: Text("Tickets",style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,fontWeight: FontWeight.bold
                ),)),
              ),
              SizedBox(height: 10,),
              Text(
                'Avathar - 2 The way of water',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'Date: June 28, 2024',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),

              Text(
                'Time: 19:00',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),


              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Seat no : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,fontWeight: FontWeight.bold
                        ),
                      ),
                      Flexible(
                        child: Wrap(
                          children: selectedSeats.map((e)=>Text("${e.seatID.toString()},  ",
                            style: TextStyle(fontWeight: FontWeight.bold),)).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 20);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(20, size.height-20, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(size.width-20, size.height-20, size.width, size.height - 20);
    path.lineTo(size.width, 20);
    path.quadraticBezierTo(size.width-20, 20, size.width - 20, 0);
    path.lineTo(20, 0);
    path.quadraticBezierTo(20, 20, 0, 20);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}