import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';
import 'package:login_flutter_app/src/repository/user_repository/user_repository.dart';

import '../../../constants/text_strings.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../../utils/helper/helper_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  
  final showPassword = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  /// [EmailAndPasswordLogin]
  Future<void> login() async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  /// [GoogleSignInAuthentication]
  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      
      await auth.signInWithGoogle();
      
      if(!await UserRepository.instance.recordExist(auth.getUserEmail)) {
        UserModel user = UserModel(email: auth.getUserEmail, password: '', fullName: auth.getDisplayName, phoneNo: auth.getPhoneNo);
        await UserRepository.instance.createUser(user);
      }
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  /// [FacebookSignInAuthentication]
  Future<void> facebookSignIn() async {
    try {
      isFacebookLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithFacebook();
      
      if(!await UserRepository.instance.recordExist(auth.getUserID)) {
        UserModel user = UserModel(email: auth.getUserEmail, password: '', fullName: auth.getDisplayName, phoneNo: auth.getPhoneNo);
        await UserRepository.instance.createUser(user);
      }
      isFacebookLoading.value = false;
    } catch (e) {
      isFacebookLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }
}
