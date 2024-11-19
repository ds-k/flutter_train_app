import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat/widget/seatRow.dart';

class SeatPage extends StatelessWidget {
  SeatPage({required this.departure, required this.arrival, super.key});

  final String departure;
  final String arrival;
  final List<Widget> seatList = List.generate(20, (idx) => seatRow(idx, false));

  @override
  Widget build(BuildContext context) {
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
                  departure,
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
                  arrival,
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
            Container(child: Expanded(child: ListView(children: seatList))),
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
                            departure: departure!,
                            arrival: arrival!,
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
