import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat_page.dart';
import 'package:flutter_train_app/station_list_page.dart';

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

  void setStation(String station, String title) {
    switch (title) {
      case "출발역":
        setState(() {
          departure = station;
        });

      case "도착역":
        setState(() {
          arrival = station;
        });
    }
  }

// dark, light
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
                      onTap: () async {
                        final data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return StationListPage(
                                title: "출발역",
                                station: station,
                              );
                            },
                          ),
                        );

                        if (data != null) setStation(data[0], data[1]);
                      },
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
                  Container(
                      width: 2,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.grey)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return StationListPage(
                                title: "도착역",
                                station: station,
                              );
                            },
                          ),
                        );
                        if (data != null) setStation(data[0], data[1]);
                      },
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
                  onPressed: (() {}),
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

/*
모서리 둥글기: 20
버튼 색상: Colors.purple
글자 색상: Colors.white
글자 크기: 18
글자 두께: FontWeight.bold
*/
