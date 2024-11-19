# 기차 예매 앱
![main](https://github.com/user-attachments/assets/269a595b-8ffb-49c3-9d6d-fe21306127cb)


---
## 구현 기능
### 필수
1. HomePage 구현
2. StationListPage 구현
3. SeatPage 구현
### 도전
1. 이미 선택한 역을 제외하는 기능
2. 다크 테마 적용
3. 나만의 기능 - 예매 내역을 볼 수 있고, 삭제할 수 있는 기능 추가

---
## 주요 기능 소개
### 출발역과 도착역 관리
* homePage를 statefulWidget으로 만들어, 출발역(departure)과 도착역(arrival) 상태를 관리했습니다.
* navigator.push와 pop을 할때, 상태를 주고 받아 stationListPage와 seatPage 간의 데이터 이동을 관리했습니다.
* 이미 선택한 역을 제거하는 기능은, staionList와 initStationList라는 두개의 배열을 선언하고, stationListPage로부터 pop 할때, stiation = List.from(initStaionList)를 하여 초기화를 해주고, stationList로부터 선택된 역을 remove하는 방식을 이용했습니다. 이는 다른 역을 선택할때의 기존 역을 초기화해야하기 때문입니다.

### 좌석 관리
* 선택된 좌석은 seatPage를 statefulWidget으로 만들어 selectedCol과 selectedRow로 상태를 관리했습니다.
* 좌석의 UI는 seatRow라는 위젯을 list.generate를 통해 펼치는 방식으로 구현하였습니다.
* 별도의 파일로 분리된 seatRow에 selectedCol과 selectedRow를 변경하는 onTapSeat 함수를 전달하여 좌석을 선택하는 순간 상태를 변경시킬 수 있도록 구현했습니다.
* 선택된 좌석 정보는 navigator.pop을 통해 homepage로 전달되고, 이는 예매 내역(reservationList)에 저장됩니다.

### 다크 모드
* 현재 themeMode는 ThemoeMode.system으로 되어있습니다.
* theme과 darkTheme을 이용하여 구현했습니다.
* 배경색은 scaffoldBackgroundColor를 이용하여 구현했습니다.
* 출발역과 도착역을 선택하는 부분의 배경 white는 다크모드시 변경될수 있도록 ThemeData 내부에 있는 cardColor라는 파라미터를 임의로 사용하여 구현하였습니다.

### 예매 내역
* 기존 UI를 해치지 않는 선에서, FloatingActionButton과 showModalBottomSheet를 통해 예매 내역을 보여주는 UI를 구현했습니다.
* UI 내부는 ListView.builder로 reservationList를 순회하며 각각의 element를 Card와 ListTile을 이용해 구현했습니다.
* depature, arrival, selectedCol, selectedRow의 상태는 seatPage로부터 pop할때 navigator.pop을 통해 homepage로 전달되고, 이는 예매 내역(reservationList)에 저장됩니다.
* reservationList는 List<Map<String, String>> 타입으로 선언하여 관리했습니다.
* 예매 내역 삭제를 누르면, reservationList로부터 해당 idx의 내역을 remove하는 방식으로 구현했습니다.
