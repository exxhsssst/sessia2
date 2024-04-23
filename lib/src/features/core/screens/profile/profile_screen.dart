import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login_flutter_app/src/common_widgets/buttons/primary_button.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';
import 'package:login_flutter_app/src/constants/text_strings.dart';
import 'package:login_flutter_app/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:login_flutter_app/src/features/core/screens/profile/widgets/image_with_icon.dart';
import 'package:login_flutter_app/src/features/core/screens/profile/widgets/profile_menu.dart';

import '../../../../repository/authentication_repository/authentication_repository.dart';
import 'all_users.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tProfile, style: Theme.of(context).textTheme.headlineMedium),
        actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSpace),
          child: Column(
            children: [
             
              const ImageWithIcon(),
              const SizedBox(height: 10),
              Text(tProfileHeading, style: Theme.of(context).textTheme.headlineMedium),
              Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),

             
              TPrimaryButton(
                isFullWidth: false,
                width: 200,
                text: tEditProfile,
                onPressed: () => Get.to(() => UpdateProfileScreen())
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              
              ProfileMenuWidget(title: "Настройки", icon: LineAwesomeIcons.cog, onPress: () {}),
              ProfileMenuWidget(title: "Платеж", icon: LineAwesomeIcons.wallet, onPress: () {}),
              ProfileMenuWidget(
                  title: "Пользователь", icon: LineAwesomeIcons.user_check, onPress: () => Get.to(() => AllUsers())),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "О нас", icon: LineAwesomeIcons.info, onPress: () {}),
              ProfileMenuWidget(
                title: "Выйти",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () => _showLogoutModal(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showLogoutModal() {
    Get.defaultDialog(
      title: "Выход",
      titleStyle: const TextStyle(fontSize: 20),
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Text("Вы уверены что хотите выйти?"),
      ),
      confirm: TPrimaryButton(
        isFullWidth: false,
        onPressed: () => AuthenticationRepository.instance.logout(),
        text: "Да",
      ),
      cancel: SizedBox(width: 100, child: OutlinedButton(onPressed: () => Get.back(), child: const Text("Нет"))),
    );
  }
}
