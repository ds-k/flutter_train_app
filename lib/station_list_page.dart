import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  const StationListPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // 변경 필요
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
