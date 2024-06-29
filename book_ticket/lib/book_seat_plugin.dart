import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';

class BusLayout extends StatefulWidget {
  const BusLayout({Key? key}) : super(key: key);

  @override
  State<BusLayout> createState() => _BusLayoutState();
}

class _BusLayoutState extends State<BusLayout> {
  Set<SeatNumber> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text("Front of bus is this side"),
            const SizedBox(
              height: 32,
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: SeatLayoutWidget(
                  onSeatStateChanged: (rowI, colI, seatState) {
                    if (seatState == SeatState.selected) {
                      selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                    } else {
                      selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                    }
                  },
                  stateModel: const SeatLayoutStateModel(
                    rows: 10,
                    cols: 7,
                    seatSvgSize: 45,
                    pathSelectedSeat: 'assets/seat_selected.svg',
                    pathDisabledSeat: 'assets/seat_disabled.svg',
                    pathSoldSeat: 'assets/seat_sold.svg',
                    pathUnSelectedSeat: 'assets/seat_unselected.svg',
                    currentSeatsState: [
                      [
                        SeatState.disabled,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.sold,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.sold,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.sold,
                        SeatState.sold,
                      ],
                      [
                        SeatState.sold,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.unselected,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                      [
                        SeatState.empty,
                        SeatState.empty,
                        SeatState.empty,
                        SeatState.empty,
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.sold,
                      ],
                      [
                        SeatState.unselected,
                        SeatState.unselected,
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.sold,
                        SeatState.unselected,
                        SeatState.unselected,
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(width: 2),
                      const Text('Disabled')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.lightBlueAccent,
                      ),
                      const SizedBox(width: 2),
                      const Text('Sold')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xff0FFF50))),
                      ),
                      const SizedBox(width: 2),
                      const Text('Available')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        color: const Color(0xff0FFF50),
                      ),
                      const SizedBox(width: 2),
                      const Text('Selected by you')
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFFfc4c4e)),
              ),
              child: const Text('Show my selected seat numbers'),
            ),
            const SizedBox(height: 12),
            Text(selectedSeats.join(" , ")),

          ],
        ),
      ),
    );
  }
}

class SeatNumber {

  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  String toString() {
    return '[$rowI][$colI]';
  }


}




class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CardView Grid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> selectedCards = [];

  void _onCardTapped(String cardId) {
    setState(() {
      // Check if card is already selected
      if (selectedCards.contains(cardId)) {
        selectedCards.remove(cardId);
      } else {
        // Calculate the row and column of the tapped card
        List<String> newSelections = [];
        int row = int.parse(cardId.split(' x ')[0]);
        int col = int.parse(cardId.split(' x ')[1]);

        // Select up to 5 cards starting from the tapped card
        for (int i = 0; i < 5; i++) {
          int newRow = row + (col + i) ~/ 20;
          int newCol = (col + i) % 20;
          String newCardId = '$newRow x $newCol';

          if (!selectedCards.contains(newCardId) && newSelections.length < 5) {
            newSelections.add(newCardId);
          }
        }

        // Add new selections to the selectedCards list
        for (String newCard in newSelections) {
          if (selectedCards.length < 5) {
            selectedCards.add(newCard);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('10x20 Selectable CardView Grid Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(10, (rowIndex) {
            return Row(
              children: List.generate(20, (colIndex) {
                String cardId = '$rowIndex x $colIndex';
                bool isSelected = selectedCards.contains(cardId);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () => _onCardTapped(cardId),
                      child: Card(
                        color: isSelected ? Colors.green : Colors.blueAccent,
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              'Card $cardId',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
