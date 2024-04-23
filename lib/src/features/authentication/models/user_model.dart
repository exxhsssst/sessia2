import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String? password;

 
  const UserModel(
      {this.id, required this.email, this.password, required this.fullName, required this.phoneNo});

  
  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
    };
  }

  
  static UserModel empty () => const UserModel(id: '', email: '', fullName: '', phoneNo: '');

  
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    
    if(document.data() == null || document.data()!.isEmpty) return UserModel.empty();
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["Почта"] ?? '',
      fullName: data["ФИО"] ?? '',
      phoneNo: data["Телефон"] ?? ''
    );
  }
}
