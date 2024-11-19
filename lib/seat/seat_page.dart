import 'package:flutter/cupertino.dart';
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
  // 선택된 좌석을 알기 위한 상태
  int? selectedCol;
  String? selectedRow;

  // 선택된 좌석으로 상태 변경하는 함수
  void onTapSeat(col, row) {
    setState(() {
      selectedCol = col;
      selectedRow = row;
    });
  }

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
            departureAndArrival(),
            labelGuide(),
            colLabel(),
            seatSelectArea(context),
            selectBtn(context)
          ],
        ),
      ),
    );
  }

  // homePage로부터 departure와 arrival을 받아 표시하는 부분
  Row departureAndArrival() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          widget.departure,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 30),
        ),
        Icon(
          Icons.arrow_circle_right_outlined,
          size: 30,
        ),
        Text(
          widget.arrival,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 30),
        ),
      ],
    );
  }

  // seat의 상태 범례
  Padding labelGuide() {
    return Padding(
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
    );
  }

  // column의 label
  Row colLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        label("A"),
        label("B"),
        label(" "),
        label("C"),
        label("D"),
      ],
    );
  }

  // 좌석 선택 영역
  SizedBox seatSelectArea(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView(
            children: List.generate(
                20,
                (col) => SeatRow(
                    col: col,
                    selectedCol: selectedCol,
                    selectedRow: selectedRow,
                    onTapSeat: onTapSeat))));
  }

  // 예매하기 버튼
  SizedBox selectBtn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {
            if (selectedCol == null || selectedRow == null) return;

            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('예매 하시겠습니까?'),
                  content: Text("좌석 : $selectedCol-$selectedRow"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text(
                        '취소',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop(
                            "출발역 : ${widget.departure} \n 도착역 : ${widget.arrival} \n 좌석 : $selectedCol-$selectedRow");
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            "예매 하기",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          )),
    );
  }
}
