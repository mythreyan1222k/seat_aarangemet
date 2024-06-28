import 'package:book_ticket/GetterSetters.dart';
import 'package:book_ticket/InputScreen.dart';
import 'package:book_ticket/selectNumberOfSeat.dart';
import 'package:book_ticket/utils.dart';
import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';

class MarkOccupiedSeats extends StatefulWidget {
  const MarkOccupiedSeats({super.key});

  @override
  State<MarkOccupiedSeats> createState() => _MarkOccupiedSeatsState();
}

class _MarkOccupiedSeatsState extends State<MarkOccupiedSeats> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select Occupied Seats',style: TextStyle(color: Colors.white),),
        backgroundColor: Utils.darkBaseColor,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Utils.btnclr1,
            child: Center(
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
            ),
          ),
        ),
      ),
      body: ZoomableList(),
      bottomSheet: Container(
        height: 70,
        width: size.width,
        decoration: BoxDecoration(color: Utils.darkBaseColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        child: SubmitButton(name: "Proceed", ontap: (){
          List<Seat> occupiedSeats=[];
          GetterSetters.instances.seatStatus.forEach((e){
            if(e.state==SeatState.occupied){occupiedSeats.add(e);}
          });
          GetterSetters.instances.occupiedSeat=occupiedSeats;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>selectNumberOfSeat()));
        }),
      ),
    );
  }
}
