import 'package:book_ticket/selectNumberOfSeat.dart';
import 'package:book_ticket/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zoom_widget/zoom_widget.dart';

import 'GetterSetters.dart';


class ZoomableList extends StatefulWidget {
  
  List<Seat>? occupiedSeat;

  ZoomableList({this.occupiedSeat});

  @override
  _ZoomableListState createState() => _ZoomableListState();
}

class _ZoomableListState extends State<ZoomableList> {
  final List<String> alphabet = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<Seat> ticketStatus = [];
  List<Seat> selectedSeats = [];
  int row = 0;
  int clm = 30;
  int totalSeat = 0;
  int seatCount=0;

  @override
  void initState() {
    super.initState();

    row = GetterSetters.instances.setrow;
    clm = GetterSetters.instances.setclm;
    seatCount = GetterSetters.instances.setseatcount;

    for (int i = 0; i < row; i++) {
      for (int j = 0; j < clm; j++) {
        ticketStatus.add(Seat(state: SeatState.available, seatID: '${alphabet[i]} ${j + 1}'));
      }
    }
    if(widget.occupiedSeat!=null){
      for(int i=0;i<widget.occupiedSeat!.length;i++){
        int j=ticketStatus.indexWhere((e)=>e.seatID==widget.occupiedSeat![i].seatID);
        ticketStatus[j]=Seat(seatID: widget.occupiedSeat![i].seatID,state: widget.occupiedSeat![i].state);
      }
    }
    totalSeat = ticketStatus.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Zoom(
          initScale: 0.1,
          maxZoomHeight: 1.0,
          maxScale: 1.6,
          backgroundColor: Colors.white,
          scrollWeight: 3.0,
          initPosition: Offset(0.0, 0.0),
          initTotalZoomOut: true,
          doubleTapZoom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: List.generate(row, (index) {
                    return Padding(
                      padding: EdgeInsets.only(top: row / 2 == index ? 20 : 0),
                      child: Row(
                        children: List.generate(clm, (index2) {
                          int i = ticketStatus.indexWhere((w) => w.seatID == '${alphabet[index]} ${index2 + 1}');
                          SeatState state = ticketStatus[i].state!;
                          String id = ticketStatus[i].seatID!;

                          return Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8, right: clm / 2 == index2 ? 20 : 8, left: 8),
                            child: GestureDetector(
                              onTap: () {

                                setState(() {
                                  if(widget.occupiedSeat!=null){
                                    if (state == SeatState.available && id == '${alphabet[index]} ${index2 + 1}') {
                                      if(selectedSeats.length<seatCount){

                                        for(int a=0;a<seatCount&&selectedSeats.length<seatCount;a++){
                                          try{
                                            if(ticketStatus[i+a].state==SeatState.available){
                                              ticketStatus[i+a] = Seat(state: SeatState.selected, seatID: '${alphabet[index]} ${(index2+a) + 1}');
                                              selectedSeats.add(ticketStatus[i+a]);
                                            }
                                          }
                                          catch(e){
                                            // ticketStatus[i] = Seat(state: SeatState.selected, seatID: '${alphabet[index]} ${index2 + 1}');
                                            // selectedSeats.add(ticketStatus[i]);
                                          }
                                        }

                                      }
                                      else{
                                        Fluttertoast.showToast(
                                            gravity: ToastGravity.CENTER,
                                            msg: "All ${seatCount} is selected");
                                      }
                                    }
                                    else if (state == SeatState.selected && id == '${alphabet[index]} ${index2 + 1}') {
                                      ticketStatus[i] = Seat(state: SeatState.available, seatID: '${alphabet[index]} ${index2 + 1}');

                                      selectedSeats.removeWhere((e) {
                                        return e.seatID=='${alphabet[index]} ${index2 + 1}';
                                      });
                                      print(selectedSeats.length);
                                    }
                                  }
                                  else{
                                    if (state == SeatState.available && id == '${alphabet[index]} ${index2 + 1}') {
                                      ticketStatus[i] = Seat(state: SeatState.occupied, seatID: '${alphabet[index]} ${index2 + 1}');
                                    }
                                    else if (state == SeatState.occupied && id == '${alphabet[index]} ${index2 + 1}') {
                                      ticketStatus[i] = Seat(state: SeatState.available, seatID: '${alphabet[index]} ${index2 + 1}');
                                    }
                                  }
                                });

                                GetterSetters.instances.seatStatus=ticketStatus;

                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: state == SeatState.occupied
                                      ? Colors.grey
                                      : state == SeatState.selected
                                      ? Colors.green.shade100
                                      : Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(height: 2,),
                                    state == SeatState.occupied
                                        ?Image(image: AssetImage('assets/occpSeat.png'),width: 20,height: 20,)
                                        : state == SeatState.selected
                                        ?Image(image: AssetImage('assets/chair.png'),width: 20,height: 20)
                                        :Image(image: AssetImage('assets/emptySeat.png'),width: 20,height: 20),
                                    Center(child: Text(" ${alphabet[index]} ${index2 + 1} ",style: TextStyle(fontSize: 10),)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 100),
                Center(
                  child: Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width * clm / 10,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Seat{
  SeatState? state;
  String? seatID;
  Seat({this.state,this.seatID});
}

enum SeatState{
  selected,
  occupied,
  available
}