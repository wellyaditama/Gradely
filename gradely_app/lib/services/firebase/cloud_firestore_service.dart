import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/user_register.dart';

class DatabaseService {
  final String uid;
  final CollectionReference accountsCollection =
      FirebaseFirestore.instance.collection('accounts');

  DatabaseService(this.uid);

  Future updateUserAccountData(UserRegister userRegister) async {
    return await accountsCollection.doc(uid).set({
      'email': userRegister.email,
      'isVerified': userRegister.isVerified,
      'name': userRegister.name,
      'university': userRegister.university,
      'gender': userRegister.gender,
      'semester': userRegister.semester,
      'currentAccountType': userRegister.currentAccountType,
    });
  }

  Future updateUserProfilePicture(String downloadURL) async {
    return await accountsCollection.doc(uid).set({
      'downloadURL': downloadURL,
    });
  }

  Stream<UserRegister> get userRegister {
    return accountsCollection.doc(uid).snapshots().map((doc) {
      return UserRegister(
          doc['email'],
          doc['isVerified'],
          doc['name'],
          doc['university'],
          doc['gender'],
          doc['semester'],
          doc['currentAccountType'],
          uid);
    });
  }
}

class DatabaseTeacherClass {
  final String uid;
  final String className;

  DatabaseTeacherClass(this.uid, this.className);

  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('classes');

  Future updateTeacherClassData(Classroom classroom) async {
    return await classCollection
        .doc(uid)
        .collection('teacherClasses')
        .doc(className)
        .set({
      'className': classroom.className,
      'subjectName': classroom.subjectName,
      'teacherName': classroom.teacherName,
      'teacherID': classroom.teacherID,
      'classPicture': classroom.classPicture,
      'classBegin': classroom.classBegin,
      'classEnd': classroom.classEnd,
      'studentCount': classroom.studentCount,
      'day': classroom.day,
      'classToken': classroom.classToken
    }).catchError((e) => print(e.toString()));
  }

  Stream<Classroom> get classroom {
    return classCollection
        .doc(uid)
        .collection('teacherClasses')
        .doc(className)
        .snapshots()
        .map((doc) {
      return Classroom(
          doc['className'],
          doc['subjectName'],
          doc['teacherName'],
          doc['teacherID'],
          doc['classPicture'],
          doc['classBegin'],
          doc['classEnd'],
          doc['studentCount'],
          doc['day'],
          doc['classToken']);
    });
  }

  Stream<QuerySnapshot> get listClassroomTeacher {
    return classCollection.doc(uid).collection('teacherClasses')
        .snapshots();
    //     .map((event) {
    //   List<Classroom> _listClassroom = [];
    //
    //   event.docs.forEach((doc) {
    //     Classroom _classroom = Classroom(
    //         doc['classname'],
    //         doc['subjectName'],
    //         doc['teacherName'],
    //         doc['teacherID'],
    //         doc['classPicture'],
    //         doc['classBegin'],
    //         doc['classEnd'],
    //         doc['studentCount'],
    //         doc['day'],
    //         doc['classToken']);
    //     _listClassroom.add(_classroom);
    //   });
    //
    //   return _listClassroom;
    // });
  }



  Future<bool> getClassroom() async {
    // List<Classroom> _listClassroom = [];
    //
    // classCollection
    //     .doc(uid)
    //     .collection('teacherClasses')
    //     .snapshots()
    //     .map((event) {
    //   for (var doc in event.docs) {
    //     Classroom _classroom = Classroom(
    //         doc['classname'],
    //         doc['subjectName'],
    //         doc['teacherName'],
    //         doc['teacherID'],
    //         doc['classPicture'],
    //         doc['classBegin'],
    //         doc['classEnd'],
    //         doc['studentCount'],
    //         doc['day'],
    //         doc['classToken']);
    //     _listClassroom.add(_classroom);
    //   }
    // });
    //
    // return _listClassroom;

    // Check if the collection exist

    return classCollection.doc(uid).collection('teacherClasses').get().then((value) {
      return value.docs.isNotEmpty;
    });

  }
}
