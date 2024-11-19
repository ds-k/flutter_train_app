import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat/widget/label.dart';
import 'package:flutter_train_app/seat/widget/seat_row.dart';

class SeatPage extends StatefulWidget {
  SeatPage({required this.departure, required this.arrival, super.key});

  final String departure;
  final String arrival;

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int? selectedCol;
  String? selectedRow;

  void onTapSeat(col, row) {
    setState(() {
      selectedCol = col;
      selectedRow = row;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("$selectedCol, $selectedRow");
    return Scaffold(
      appBar: AppBar(
        title: Text("좌석 선택"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.departure,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 30),
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                ),
                Text(
                  widget.arrival,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 30),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text("선택됨")
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text("선택안됨")
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                label("A"),
                label("B"),
                label(" "),
                label("C"),
                label("D"),
              ],
            ),
            Expanded(
                child: ListView(
                    children: List.generate(
                        20,
                        (col) => seatRow(
                            col: col,
                            selectedCol: selectedCol,
                            selectedRow: selectedRow,
                            onTapSeat: onTapSeat)))),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: (() async {
                    final data = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SeatPage(
                            departure: widget.departure!,
                            arrival: widget.arrival!,
                          );
                        },
                      ),
                    );
                    if (data == null) return;
                  }),
                  child: Text(
                    "예매 하기",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
