import 'package:flutter/material.dart';
import 'package:gradely_app/model/history.dart';
import 'history_list_tile.dart';

class HistoryList extends StatefulWidget {
  final List<TeacherHistory> listHistory;

  const HistoryList({Key? key, required this.listHistory}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.listHistory.length,
      itemBuilder: (BuildContext context, int index) {
        return HistoryListTile(
          teacherHistory: widget.listHistory[index],
        );
      },
    );
  }
}