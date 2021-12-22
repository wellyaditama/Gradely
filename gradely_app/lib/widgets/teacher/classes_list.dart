import 'package:flutter/material.dart';
import 'package:gradely_app/common/constant.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:provider/provider.dart';

import 'classes_list_tile.dart';

class ClassesList extends StatefulWidget {
  final List<Classroom> classrooms;

  const ClassesList({Key? key, required this.classrooms}) : super(key: key);

  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.classrooms.length,
      itemBuilder: (BuildContext context, int index) {
        return ClassesListTile(classroom: widget.classrooms[index],);
      },
    );
  }
}
