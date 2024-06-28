class GetterSetters{
  GetterSetters._GetterSetters();
static GetterSetters instances=GetterSetters._GetterSetters();

int? _row;
int? _clm;
int? _seatCount;

 set setrow(int val){
   _row=val;
 }
  set setclm(int val){
    _clm=val;
  }
  set setseatcount(int val){
    _seatCount=val;
  }

 int get setrow=>_row!;
 int get setclm=>_clm!;
 int get setseatcount=>_seatCount!;

}