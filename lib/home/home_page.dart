import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat/seat_page.dart';
import 'package:flutter_train_app/stationList/station_list_page.dart';

enum StationType { departure, arrival }

class HomePage extends StatefulWidget {
  final String? selectedStation;

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
  // 역 리스트 초기화하기 위해 List 추가
  List<String> initStation = [
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
    "부산",
  ];

  List<Map<String, String>> reservationList = [];

  String? departure;
  String? arrival;

  // stationListPage로부터 데이터를 받아와 상태인 departure와 arrival에 등록하는 함수
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
          station = List.from(
              initStation); // 같은 리스트로 카피가 되는 현상을 발견해서, 찾아보고 메서드를 적용했습니다.
          departure = data[0];
          station.remove(departure);
        });

      case "도착역":
        setState(() {
          station = List.from(initStation);
          arrival = data[0];
          station.remove(arrival);
        });
    }
  }

  // 예매 완료 이후 dapartment와 arrival을 초기화하는 함수
  void setIntialDepartmentAndArrival() {
    setState(() {
      departure = null;
      arrival = null;
    });
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
            selectCard(context),
            SizedBox(
              height: 20,
            ),
            selectBtn(context)
          ],
        ),
      ),
      floatingActionButton: revationListView(context),
    );
  }

  // 역 선택 카드
  Container selectCard(BuildContext context) {
    return Container(
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
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
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
    );
  }

  // 좌석 선택 버튼
  SizedBox selectBtn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: (() async {
            if (departure == null || arrival == null) {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('오류'),
                    content: Text("출발역과 도착역을 선택해주세요."),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text(
                          '확인',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              return;
            }
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
            setIntialDepartmentAndArrival();
            setState(() {
              reservationList.add(data);
            });
          }),
          child: Text(
            "좌석 선택",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          )),
    );
  }

  // 나만의 기능 : 예매 내역 볼 수 있는 페이지
  FloatingActionButton revationListView(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(24.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "예매 내역",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    reservationList.isEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("예매 내역이 없습니다.")
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: reservationList.length,
                              itemBuilder: (BuildContext context, int idx) {
                                return Card(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text(
                                        reservationList[idx]["title"]!,
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      subtitle: Text(
                                          "좌석 : ${reservationList[idx]["seat"]!}"),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          showCupertinoDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                title: Text('예매를 취소하시겠습니까?'),
                                                content: Text(
                                                    "${reservationList[idx]["title"]!}, 좌석: ${reservationList[idx]["seat"]!}"),
                                                actions: <Widget>[
                                                  CupertinoDialogAction(
                                                    child: Text(
                                                      '취소',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: Text(
                                                      '확인',
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        reservationList
                                                            .removeAt(idx);
                                                      });

                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.cancel_outlined,
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                  ],
                ),
              );
            });
      },
      backgroundColor: Colors.purple,
      shape: CircleBorder(),
      child: Icon(
        Icons.format_list_bulleted,
        color: Colors.white,
      ),
    );
  }
}
