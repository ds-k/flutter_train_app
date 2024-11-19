import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat/seat_page.dart';
import 'package:flutter_train_app/stationList/station_list_page.dart';

enum StationType { departure, arrival }

class HomePage extends StatefulWidget {
  String? selectedStation;

  HomePage({this.selectedStation, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> station = [
    "수서",
    "동탄",
    "평택지제",
    "천안아산",
    "오송",
    "대전",
    "김천구미",
    "동대구",
    "경주",
    "울산",
    "부산"
  ];

  String? departure;
  String? arrival;

  void setStation(String title) async {
    final data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return StationListPage(
            title: title,
            station: station,
          );
        },
      ),
    );
    if (data == null) return;

    switch (data[1]) {
      case "출발역":
        setState(() {
          departure = data[0];
        });

      case "도착역":
        setState(() {
          arrival = data[0];
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("기차 예매"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setStation("출발역"),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("출발역",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            departure ?? "선택",
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                    height: 50,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey)),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setStation("도착역"),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("도착역",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            arrival ?? "선택",
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                    print("$data");
                  }),
                  child: Text(
                    "좌석 선택",
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
