import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/history.dart';

class HistoryListTile extends StatefulWidget {
  const HistoryListTile({Key? key, required this.teacherHistory}) : super(key: key);
  final TeacherHistory teacherHistory;

  @override
  _HistoryListTileState createState() => _HistoryListTileState();
}

class _HistoryListTileState extends State<HistoryListTile> {
  @override
  Widget build(BuildContext context) {
    bool isPracticum = widget.teacherHistory.title == 'Practicum Session';

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        color: StyleColors.primaryColor,
        child: ListTile(
          leading: (isPracticum)
              ? Image.asset(
            'assets/ic_lecture.png',
            width: 50.0,
            height: 50.0,
          )
              : Image.asset(
            'assets/ic_grade.png',
            width: 50.0,
            height: 50.0,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              widget.teacherHistory.title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0),
            ),
          ),
          subtitle: Text(
            widget.teacherHistory.description + '\n' + widget.teacherHistory.date,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.0,
                color: Colors.black45
            ),
          ),
        ),
      ),
    );
  }
}
