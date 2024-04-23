import 'package:flutter/material.dart';

class DashboardCategoriesModel{
  final String title;
  final String heading;
  final String subHeading;
  final VoidCallback? onPress;

  DashboardCategoriesModel(this.title, this.heading, this.subHeading, this.onPress);

  static List<DashboardCategoriesModel> list = [
    DashboardCategoriesModel("Б", "Бургеры", "10 Видов", null),
    DashboardCategoriesModel("П", "Пицца", "11 Видов", null),
    DashboardCategoriesModel("Н", "Напитки", "8 Видов", null),
    DashboardCategoriesModel("Д", "Десерты", "20 Видов", null),
    DashboardCategoriesModel("С", "Соус", "10 Видов", null),
  ];
}