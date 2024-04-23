import 'package:get/get.dart';
import 'package:login_flutter_app/src/constants/text_strings.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:login_flutter_app/src/repository/user_repository/user_repository.dart';

import '../../../utils/helper/helper_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  
  final _authRepo = AuthenticationRepository.instance;
  final _userRepo = UserRepository.instance;

  
  getUserData() async {
    try {
      final currentUserEmail = _authRepo.getUserEmail;
      if (currentUserEmail.isNotEmpty) {
        return await _userRepo.getUserDetails(currentUserEmail);
      } else {
        Helper.warningSnackBar(title: 'Ошибка', message: 'Пользователь не найден');
        return;
      }
    } catch (e) {
      Helper.errorSnackBar(title: 'Ошибка', message: e.toString());
    }
  }

  
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();

  
  updateRecord(UserModel user) async {
    try {
      await _userRepo.updateUserRecord(user);
      
      Helper.successSnackBar(title: tCongratulations, message: 'Профиль был обновлен');
    } catch (e) {
      Helper.errorSnackBar(title: 'Ошибка', message: e.toString());
    }
  }

  Future<void> deleteUser() async {
    try {
      String uID = _authRepo.getUserID;
      if (uID.isNotEmpty) {
        await _userRepo.deleteUser(uID);
        
        Helper.successSnackBar(title: tCongratulations, message: 'Аккаунт удален');
      } else {
        Helper.successSnackBar(title: 'Ошибка', message: 'Пользователь не может быть удален');
      }
    } catch (e) {
      Helper.errorSnackBar(title: 'Ошибка', message: e.toString());
    }
  }
}
