import 'package:book_ticket/seatArrangement.dart';

class GetterSetters {
  GetterSetters._GetterSetters();

  static GetterSetters instances = GetterSetters._GetterSetters();

  int? _row;
  int? _clm;
  int? _seatCount;
  List<Seat> _ticketStatus = [];
  List<Seat> _selectedSeat = [];
  List<Seat> _occupiedSeat = [];

  set setrow(int val) {
    _row = val;
  }

  set setclm(int val) {
    _clm = val;
  }

  set setseatcount(int val) {
    _seatCount = val;
  }

  set seatStatus(List<Seat> status){
    _ticketStatus=status;
  }

  set selectedSeat(List<Seat> seats){
    _selectedSeat=seats;
  }

set occupiedSeat(List<Seat> seats){
    _occupiedSeat=seats;
  }

  int get setrow => _row??0;

  int get setclm => _clm??0;

  int get setseatcount => _seatCount??0;

  List<Seat> get seatStatus=>_ticketStatus??[];

  List<Seat> get selectedSeat=>_selectedSeat??[];

  List<Seat> get occupiedSeat=>_occupiedSeat??[];
}
