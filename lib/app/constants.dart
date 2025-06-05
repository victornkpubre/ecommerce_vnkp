import 'package:flutter/material.dart';
class AppConstants {
  static int  pageSize = 8;
  static double shippingFee = 10;
}

class AppIcons {
  static const String home = "assets/icons/hugeicons_home-07.svg";
  static const String add = "assets/icons/hugeicons_add-01.svg";
  static const String minus = "assets/icons/hugeicons_minus-sign.svg";
  static const String delete = "assets/icons/hugeicons_delete-02.svg";
  static const String favorite = "assets/icons/hugeicons_favourite.svg";
  static const String cart = "assets/icons/hugeicons_shopping-cart-01.svg";
  static const String notification = "assets/icons/hugeicons_notification-02.svg";
  static const String user = "assets/icons/hugeicons_user-circle.svg";
}

class AppColor {
  static Color primaryColor = const Color(0xFF60B5FF);
  static Color secondaryColor = const Color(0xFF078CFF);
}
class AppString {
  static String address  = "DELIVERY ADDRESS";
  static String state  = "Umezike Road, Oyo State";
  static String tech  = "Technology";
  static String back  = "Go back";
  static String about  = "About this item";
  static String add  = "Add to cart";
}

class AppTextStyle {
  static TextStyle details = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: Colors.black26
  );
}