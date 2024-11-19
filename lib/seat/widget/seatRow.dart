import 'package:flutter/material.dart';

Widget seatRow(int idx, bool isSelected) {
  Widget seat = GestureDetector(
    onTap: () {
      !isSelected;
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300]!,
          borderRadius: BorderRadius.circular(8)),
    ),
  );
  return Row(
    children: [seat, seat, Text((idx + 1).toString()), seat, seat],
  );
}
