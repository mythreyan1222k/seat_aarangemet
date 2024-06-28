import 'package:book_ticket/GetterSetters.dart';
import 'package:book_ticket/InputScreen.dart';
import 'package:book_ticket/selectNumberOfSeat.dart';
import 'package:book_ticket/utils.dart';
import 'package:book_ticket/seatArrangement.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'TicketWidget.dart';

class ConfirmationScreen extends StatefulWidget {

   ConfirmationScreen({super.key,});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Utils.darkBaseColor,
      appBar: AppBar(
        title: Text('Ticket Confirmation',style: TextStyle(color: Colors.white),),
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
      body: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: size.height/4,width: size.width,
          child: Row(children: [
            SizedBox(width: 20,),
            Expanded(
                flex: 1,
                child: Image(image: AssetImage('assets/poster.png'),fit: BoxFit.contain,)),
            Expanded(
                flex: 2,
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(width: 10,),
                      Icon(Icons.location_on,color: Colors.white,size: 40,),SizedBox(width: 20,),
                      Text("Cinema Theater",style: TextStyle(color: Colors.white),),Spacer(),
                    ],),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 10,),
                  Icon(Icons.movie_creation,color: Colors.white,size: 40,),SizedBox(width: 20,),
                  Text("Avathar 2",style: TextStyle(color: Colors.white),),Spacer(),
                ],),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 10,),
                  Icon(Icons.date_range,color: Colors.white,size: 40,),SizedBox(width: 20,),
                  Text("28-06-2024",style: TextStyle(color: Colors.white),),Spacer(),
                ],),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 10,),
                  Icon(Icons.video_camera_front,color: Colors.white,size: 40,),SizedBox(width: 20,),
                  Text("Dubbed",style: TextStyle(color: Colors.white),),Spacer(),
                ],),

              ],),
            ))
          ],),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Divider(),
        ),
        SizedBox(height: 20,),
        TicketWidget(),
        SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 0),
          child: SubmitButton(name: "Book More Tickets", ontap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>selectNumberOfSeat()));
          },oultine: true,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
          child: SubmitButton(name: "Confirm Booking", ontap: (){
            Fluttertoast.showToast(gravity: ToastGravity.CENTER,msg:"Tickets Booked Successfully");
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>InputScreen()), (Route<dynamic> route) => false,);
          }),
        )
      ],),
    );
  }
}
