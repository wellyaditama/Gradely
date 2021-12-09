class Classroom {

  static final List<String> dayList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  final String className;
  final String subjectName;
  final String teacherName;
  final String teacherID;
  final String classPicture;
  final DateTime classBegin;
  final DateTime classEnd;
  final int studentCount;
  final String day;

  Classroom(this.className, this.subjectName, this.teacherName, this.teacherID,
      this.classPicture, this.classBegin, this.classEnd, this.studentCount, this.day);
}
