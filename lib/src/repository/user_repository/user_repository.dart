import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';
import '../authentication_repository/exceptions/t_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  
  Future<void> createUser(UserModel user) async {
    try {
      
      await recordExist(user.email) ? throw "Уже существует" : await _db.collection("Пользователи").add(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty ? 'Что то пошло не так, попробуй снова' : e.toString();
    }
  }

  
  Future<UserModel> getUserDetails(String email) async {
    try {
      

      final snapshot = await _db.collection("Пользователи").where("Почта", isEqualTo: email).get();
      if (snapshot.docs.isEmpty) throw 'Пользователь не найден';

     
      final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty ? 'Что то пошло не так, попробуй снова' : e.toString();
    }
  }

  
  Future<List<UserModel>> allUsers() async {
    try {
      final snapshot = await _db.collection("Пользователи").get();
      final users = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return users;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Что то пошло не так, попробуй снова';
    }
  }

  
  Future<void> updateUserRecord(UserModel user) async {
    try {
      await _db.collection("Пользователи").doc(user.id).update(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Что то пошло не так, попробуй снова';
    }
  }

  
  Future<void> deleteUser(String id) async {
    try {
      await _db.collection("Users").doc(id).delete();
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Что то пошло не так, попробуйте снова';
    }
  }

  
  Future<bool> recordExist(String email) async {
    try {
      final snapshot = await _db.collection("Пользователи").where("Почта", isEqualTo: email).get();
      return snapshot.docs.isEmpty ? false : true;
    } catch (e) {
      throw "Ошибка";
    }
  }
}
