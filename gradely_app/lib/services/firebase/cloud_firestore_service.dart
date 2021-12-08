
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradely_app/model/user_register.dart';

class DatabaseService {
  final String uid;
  final CollectionReference accountsCollection = FirebaseFirestore.instance.collection('accounts');

  DatabaseService(this.uid);

  Future updateUserAccountData(UserRegister userRegister) async{
    return await accountsCollection.doc(uid).set({
      'email' : userRegister.email,
      'isVerified' : userRegister.isVerified,
      'name' : userRegister.name,
      'university' : userRegister.university,
      'gender' : userRegister.gender,
      'semester' : userRegister.semester,
      'currentAccountType' : userRegister.currentAccountType,
    });
  }


  Stream<UserRegister> get userRegister {
    return accountsCollection.doc(uid).snapshots().map((doc) {
      return UserRegister(doc['email'], doc['isVerified'], doc['name'], doc['university'], doc['gender'], doc['semester'], doc['currentAccountType'], uid);
    });
  }
}