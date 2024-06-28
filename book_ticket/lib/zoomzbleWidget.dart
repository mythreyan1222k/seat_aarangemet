import 'package:book_ticket/selectNumberOfSeat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zoom_widget/zoom_widget.dart';

import 'GetterSetters.dart';


class ZoomableList extends StatefulWidget {
  final int row;
  final int clm;
  final int? seatCount;
  List<Seat>? occupiedSeat;

  ZoomableList({required this.row, required this.clm,this.occupiedSeat,this.seatCount});

  @override
  _ZoomableListState createState() => _ZoomableListState();
}

class _ZoomableListState extends State<ZoomableList> {
  final List<String> alphabet = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<Seat> ticketStatus = [];
  List<Seat> occupiedSeats = [];
  List<Seat> selectedSeats = [];
  int row = 0;
  int clm = 30;
  int totalSeat = 0;

  @override
  void initState() {
    super.initState();

    row = GetterSetters.instances.setrow;
    clm = GetterSetters.instances.setclm;
    // Initialize your ticketStatus list or any other initialization logic
    // Ensure ticketStatus is initialized properly
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select UnAvailable Seats'),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Zoom(
              initScale: 0.1,
              backgroundColor: Colors.white,
              scrollWeight: 3.0,
              initPosition: Offset(0.0, 0.0),
              initTotalZoomOut: true,
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
                                          if(selectedSeats.length<widget.seatCount!){
                                            ticketStatus[i] = Seat(state: SeatState.selected, seatID: '${alphabet[index]} ${index2 + 1}');
                                            selectedSeats.add(ticketStatus[i]);
                                          }
                                          else{
                                            Fluttertoast.showToast(msg: "All ${widget.seatCount} is selected");
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
                                        else if (state == SeatState.selected && id == '${alphabet[index]} ${index2 + 1}') {
                                          ticketStatus[i] = Seat(state: SeatState.available, seatID: '${alphabet[index]} ${index2 + 1}');
                                        }
                                      }
                                    });

                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: state == SeatState.occupied
                                        ? Colors.grey
                                        : state == SeatState.selected
                                        ? Colors.amber
                                        : Colors.green,
                                    child: Center(child: Text(" ${alphabet[index]} ${index2 + 1} ")),
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
          Align(alignment: Alignment.bottomCenter,
            child: ElevatedButton(onPressed: (){
              ticketStatus.forEach((e){
                if(e.state==SeatState.occupied){occupiedSeats.add(e);}
              });
              Navigator.push(context, MaterialPageRoute(builder: (context)=>selectNumberOfSeat(
                  clm: widget.clm, row: widget.row,occupiedSeat: occupiedSeats,)));

            }, child: Text("Proceed")),
          )
        ],
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