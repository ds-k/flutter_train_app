import 'package:flutter/material.dart';

class seatRow extends StatefulWidget {
  seatRow(
      {required this.col,
      required this.onTapSeat,
      this.selectedCol,
      this.selectedRow,
      super.key});

  final int col;

  int? selectedCol;
  String? selectedRow;
  Function onTapSeat;

  @override
  State<seatRow> createState() => _seatRowState();
}

class _seatRowState extends State<seatRow> {
  Widget seat(String row) {
    return GestureDetector(
      onTap: () {
        // 상태 변화를 시킬수 있는 함수
        widget.onTapSeat(widget.col + 1, row);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: row == widget.selectedRow &&
                    widget.col + 1 == widget.selectedCol
                ? Colors.purple
                : Colors.grey[300]!,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(Object context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        seat("A"),
        seat("B"),
        Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: Text((widget.col + 1).toString())),
        seat("C"),
        seat("D")
      ],
    );
  }
}
