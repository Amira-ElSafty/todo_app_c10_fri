import 'package:flutter/material.dart';

class MyTheme {
  /// colors , light theme , dark theme
  static Color primaryColor = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffffffff);
  static Color backgroundLightColor = Color(0xffDFECDB);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackLightColor = Color(0xff383838);
  static Color grayColor = Color(0xff8a909a);
  static Color backgroundDarkColor = Color(0xff060E1E);
  static Color blackDarkColor = Color(0xff141922);
  static Color grayDarkColor = Color(0xff707070);

  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundLightColor,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: grayColor,
          backgroundColor: Colors.transparent,
          elevation: 0),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: primaryColor, width: 4))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: StadiumBorder(side: BorderSide(color: whiteColor, width: 4)),
          backgroundColor: primaryColor
          // RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(30),
          //   side: BorderSide(
          //     color: whiteColor,
          //     width: 4
          //   )
          // )

          ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
        titleMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: blackLightColor),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: blackLightColor),
      ));
}
