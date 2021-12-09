import 'package:flutter/material.dart';
import 'package:gradely_app/common/constant.dart';
import 'package:gradely_app/common/styles.dart';

class ClassesList extends StatefulWidget {
  const ClassesList({Key? key}) : super(key: key);

  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Container(
            color: Styles.primaryColor,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200.0),
                  child: FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: 100.0,
                    placeholder: 'assets/ic_teacher_male.png',
                    image: ConstantVariables.iconDefaultTeacherMale,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('Nama Matakuliah'),
                Text('Nama Dosen')
              ],
            ),
          ),
        );
      },
    );
  }
}
