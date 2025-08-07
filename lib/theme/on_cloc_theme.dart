import 'package:flutter/material.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';

abstract class OnClocTheme {
  static var fontFamily = 'Lexend';

  static final ThemeData lightTheme = ThemeData(
    splashColor: Colors.transparent, // Removes the splash color
    highlightColor: Colors.transparent, // Removes the highlight color
    scaffoldBackgroundColor: servpalBgColorLight,
    primaryColor: servpalPrimaryColor,
    primaryColorDark: servpalPrimaryColor,
    hoverColor: Colors.white54,
    dividerColor: servpalViewlineColorLight,
    fontFamily: fontFamily,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: servpalBgColorLight,
    ),
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: servpalBgColorLight,
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.green,
      selectionHandleColor: Colors.black,
    ),
    colorScheme: const ColorScheme.light(primary: Colors.white),
    //cardTheme: const CardTheme(color: Colors.white),
    cardColor: servpalCardBgColorLight,
    iconTheme: const IconThemeData(color: Colors.black),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: servpalBgColorLight),
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(color: servpalTextColorLight, fontFamily: fontFamily),
      labelSmall: TextStyle(fontFamily: fontFamily, color: servpalTextColorLight),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 48.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 40.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 32.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.0,
        fontFamily: fontFamily,
        color: servpalTextColorLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 18.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: servpalTextColorLight,
        fontFamily: fontFamily,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    popupMenuTheme: const PopupMenuThemeData(color: servpalBgColorLight),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    splashColor: Colors.transparent, // Removes the splash color
    highlightColor: Colors.transparent, // Removes the highlight color
    scaffoldBackgroundColor: servpalBgColorDark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: servpalBgColorDark,
    ),
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: servpalBgColorDark),
      titleTextStyle: TextStyle(color: Colors.white),
      backgroundColor: servpalBgColorDark,
      iconTheme: IconThemeData(color: servpalBgColorDark),
    ),
    primaryColor: servpalPrimaryColorDark,
    primaryColorDark: servpalPrimaryColorDark,
    dividerColor: const Color(0xFFDADADA).withValues(alpha:  0.3),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.green,
      selectionHandleColor: Colors.white,
    ),
    hoverColor: Colors.black12,
    fontFamily: fontFamily,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: servpalBgColorDark,
    ),
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontFamily: fontFamily),
      labelSmall: TextStyle(color: Colors.white, fontFamily: fontFamily),
    ),
    //cardTheme: const CardTheme(color: servpalPrimaryColorDark),
    cardColor: servpalCardBgColorDark,
    iconTheme: const IconThemeData(color: servpalBgColorDark),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 48.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 40.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 32.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 18.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: servpalTextColorDark,
        fontFamily: fontFamily,
      ),
    ),
    popupMenuTheme: const PopupMenuThemeData(color: servpalTextColorDark),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(
      primary: servpalPrimaryColorDark,
      onPrimary: servpalCardBgColorDark,
    ).copyWith(secondary: servpalBgColorDark),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}
