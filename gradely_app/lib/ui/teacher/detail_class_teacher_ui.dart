import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/ui/teacher/class_begin_ui.dart';
import 'package:gradely_app/widgets/widget_big_qr_code_image.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class DetailClassTeacher extends StatefulWidget {
  final Classroom classroom;

  const DetailClassTeacher({Key? key, required this.classroom})
      : super(key: key);

  @override
  State<DetailClassTeacher> createState() => _DetailClassTeacherState();
}

class _DetailClassTeacherState extends State<DetailClassTeacher> {
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    String qrData = widget.classroom.teacherID +
        widget.classroom.className +
        widget.classroom.classToken;

    print(qrData);
  }

  @override
  Widget build(BuildContext context) {
    String qrData = widget.classroom.teacherID +
        widget.classroom.className +
        widget.classroom.classToken;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Class'),
        backgroundColor: Styles.primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              shareQRCode('Join to class ' + widget.classroom.subjectName + ' ' + widget.classroom.className + '\nToken : $qrData');
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10.0,
              ),
              RepaintBoundary(
                key: globalKey,
                child: WidgetBigQRCodeImage(qrData: qrData),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Subject Name :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.school),
                  hintText: widget.classroom.subjectName,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Class :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.home),
                  hintText: widget.classroom.className,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Teacher Name :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.school),
                  hintText: widget.classroom.teacherName,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Day :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.event),
                  hintText: widget.classroom.day,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Class Begin : ' + Utility.convertDateTimeToString(widget.classroom.classBegin),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Class End : ' + Utility.convertDateTimeToString(widget.classroom.classEnd),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClassBegin(classroom: widget.classroom),));
                  },
                  child: Text('Begin this Class'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareQRCode(String message) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();

      final path = '${tempDir.path}/image.png';
      File(path).writeAsBytesSync(pngBytes);

      await Share.shareFiles([path], text: message);
    } catch (e) {
      print(e.toString());
    }
  }
}
