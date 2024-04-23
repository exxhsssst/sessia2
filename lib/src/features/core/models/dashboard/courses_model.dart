import 'package:flutter/material.dart';
import 'package:login_flutter_app/src/constants/image_strings.dart';

class DashboardTopCoursesModel{
  final String title;
  final String heading;
  final String subHeading;
  final String image;
  final VoidCallback? onPress;

  DashboardTopCoursesModel(this.title, this.heading, this.subHeading, this.image, this.onPress);

  static List<DashboardTopCoursesModel> list = [
    DashboardTopCoursesModel("Манты", "10 Штук", "С мясом", tTopCourseImage1, (){}),
    DashboardTopCoursesModel("Бургер", "2 Котлеты", "350 грамм", tTopCourseImage2, null),
    DashboardTopCoursesModel("Хинкали", "6 Штук", "С мясом", tTopCourseImage1, (){}),
  ];
}