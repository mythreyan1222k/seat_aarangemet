import 'package:book_ticket/ConfirmationScreen.dart';
import 'package:book_ticket/selectNumberOfSeat.dart';
import 'package:book_ticket/utils.dart';
import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'GetterSetters.dart';
import 'InputScreen.dart';

class MarkSelectedSeats extends StatefulWidget {

  MarkSelectedSeats({super.key,});

  @override
  State<MarkSelectedSeats> createState() => _MarkSelectedSeatsState();
}

class _MarkSelectedSeatsState extends State<MarkSelectedSeats> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select Seats To Booking',style: TextStyle(color: Colors.white),),
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
      body: ZoomableList(occupiedSeat: GetterSetters.instances.occupiedSeat,),
      bottomSheet: Container(
        height: 100,
        width: size.width,
        decoration: BoxDecoration(color: Utils.darkBaseColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Spacer(),
              Image(image: AssetImage('assets/occpSeat.png'),width: 20,height: 20,),
              Text("Occupied seat",style: TextStyle(color: Colors.white),),Spacer(),
              Image(image: AssetImage('assets/chair.png'),width: 20,height: 20,),
              Text("Selected seat",style: TextStyle(color: Colors.white),),Spacer(),
              Image(image: AssetImage('assets/emptySeat.png'),width: 20,height: 20,color: Colors.white,),
              Text("Available seat",style: TextStyle(color: Colors.white),),Spacer(),
            ],),SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SubmitButton(name: "Confirm Seats", ontap: (){
                List<Seat> selectedSeats=[];
                GetterSetters.instances.seatStatus.forEach((e){
                  if(e.state==SeatState.selected){selectedSeats.add(e);}
                });
                GetterSetters.instances.selectedSeat=selectedSeats;
                if(selectedSeats.length==GetterSetters.instances.setseatcount){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmationScreen()));
                }else{
                  Fluttertoast.showToast(msg: "Please select the seats.");
                }

              }),
            ),
          ],
        ),
      ),
    );
  }

}
