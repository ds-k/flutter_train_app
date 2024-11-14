import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  const StationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("출발역"), // 변경 필요
      ),
      body: Column(
        children: [
          Container(
            child: Text("수서"),
          ),
        ],
      ),
    );
  }
}
