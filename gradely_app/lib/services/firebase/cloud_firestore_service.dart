import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/user_register.dart';

class DatabaseService {
  final String uid;
  final CollectionReference accountsCollection = FirebaseFirestore.instance
      .collection('accounts');

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

  final CollectionReference classCollection = FirebaseFirestore.instance
      .collection('classes');


  Future updateTeacherClassData(Classroom classroom) async {
    return await classCollection.doc(uid).collection('teacherClasses').doc(
        className).set({
      'className': classroom.className,
      'subjectName': classroom.subjectName,
      'teacherName': classroom.teacherName,
      'teacherID': classroom.teacherID,
      'classPicture': classroom.classPicture,
      'classBegin': classroom.classBegin,
      'classEnd': classroom.classEnd,
      'studentCount': classroom.studentCount,
      'day': classroom.day,
    }).catchError((e) => print(e.toString()));
  }

  Stream<Classroom> get classroom {
    return classCollection.doc(uid).collection('teacherClasses')
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
          doc['day']);
    });
  }
}