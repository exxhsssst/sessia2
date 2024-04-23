import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';
import 'package:login_flutter_app/src/repository/user_repository/user_repository.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final showPassword = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  
  final isLoading = false.obs;

  
  Future<void> createUser() async {
    try {
      isLoading.value = true;
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      

      
      final user = UserModel(
        email: email.text.trim(),
        password: password.text.trim(),
        fullName: fullName.text.trim(),
        phoneNo: phoneNo.text.trim(),
      );

      
      final auth = AuthenticationRepository.instance;
      await auth.registerWithEmailAndPassword(user.email, user.password!);
      await UserRepository.instance.createUser(user);
      auth.setInitialScreen(auth.firebaseUser);

    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }
  }

  /// [PhoneNoAuthentication]
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
    } catch (e) {
      throw e.toString();
    }
  }
}
