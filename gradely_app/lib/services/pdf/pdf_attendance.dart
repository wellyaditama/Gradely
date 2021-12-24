import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/student_grade.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/services/pdf/pdf_api.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

class PdfAttendance {
  static Future<File> generate(
      Classroom classroom, List<Student> listStudent) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(classroom),
          SizedBox(height: 3 * PdfPageFormat.cm),
          buildAttendanceStudent(listStudent),
        ],
        footer: (context) => buildFooter(),
      ),
    );
    String pdfName = 'attendance' + classroom.className + ' ' + classroom.teacherName;

    return PdfApi.saveDocument(name: pdfName, pdf: pdf);
  }

  static buildHeader(Classroom classroom) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDetailClass(classroom),
          Container(
            height: 50,
            width: 50,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: classroom.teacherID+classroom.className+classroom.classToken,
            ),
          ),
        ],
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildClassDetail(classroom),
          buildClassInfo(classroom),
        ],
      ),
    ],
  );

  static Widget buildDetailClass(Classroom classroom) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Report Attendance', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
    ],
  );

  static Widget buildClassInfo(Classroom classroom) {
    final titles = <String>[
      'Class Token :',
      'Teacher ID :',
      'Date :',
    ];
    final data = <String>[
      classroom.classToken,
      classroom.teacherID.substring(0, 10),
      Utility.convertDateToYmd(DateTime.now()),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildHeaderText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildClassDetail(Classroom classroom) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(classroom.teacherName, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(classroom.className),
    ],
  );

  static Widget buildAttendanceStudent(List<Student> listStudent) {
    final headers = [
      'Student ID',
      'Email',
      'Name',
      'Grade',
    ];
    final data = listStudent.map((student) {

      return [
        student.uid.substring(0, 10),
        student.email,
        student.name,
        Utility.convertDateToTime(student.attendanceTime),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.center,
      },
    );
  }

  static buildHeaderText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static buildFooterText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static Widget buildFooter() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildFooterText(title: 'Made with : ', value: 'Gradely'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      buildFooterText(title: 'Contact : ', value: 'wellyaditama12@gmail.com'),
    ],
  );
}
