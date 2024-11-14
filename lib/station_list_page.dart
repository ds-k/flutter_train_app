import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  const StationListPage(
      {required this.title, required this.station, super.key});

  final String title;
  final List<String> station;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     color: Color.fromRGBO(255, 246, 249, 1)), // appBar와 색상을 맞추기
        child: ListView(
            children: List.generate(station.length, (idx) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, [station[idx], title]);
            },
            child: Container(
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
              width: double.infinity,
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text(
                station[idx],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        })),
      ),
    );
  }
}
