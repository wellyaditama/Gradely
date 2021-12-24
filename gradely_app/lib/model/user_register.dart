class UserRegister {
  final String uid;
  final String email;
  final bool isVerified;
  final String name;
  final String university;
  final String gender;
  final int semester;
  final String currentAccountType;

  UserRegister(this.email, this.isVerified, this.name, this.university, this.gender, this.semester, this.currentAccountType, this.uid);
}