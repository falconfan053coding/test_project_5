import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class MyColors {
  static const primary = Color(0xffc93535);
  static const onPrimary = Color(0xffB3E55E);
  static const greenAccent = Color(0xff6CB549);
  static const background = Color(0xffF7F7F7);
  static const onBackground = Color(0xffffffff);
  static const inactive = Color(0xff9092A0);
  static const customRed = Color(0XFFFF007A);
  static const customPink = Color(0xFFF71757);
  static const orange = Color(0xffFC9700);
  static const onFont = Color(0xff828282);
  static const containerColor = Color(0xffB9B9C9);
  static const shimmerColor = Color(0xff4f4f4f);
  static const labelColors = Color(0xff828282);
  static const black = Color(0xff000000);
  static const white = Color(0xffffffff);
  static const green = Color(0xff217355);
  static const blue = Color(0xff00A1D3);
  static const red = Colors.red;
  static const hintText = Color(0xffA8AAB0);
  static const textColor = Color(0xff272A39);
  static const fieldBackColor = Color(0xffF2F2F2);
  static const buttonBgColor = Color(0xffF7F7F7);
}

final lightTheme = ThemeData(
  scaffoldBackgroundColor: MyColors.background,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: MyColors.primary,
    background: MyColors.background,
    onBackground: MyColors.onBackground,
  ),
  // textTheme: TextTheme(
  //   displayLarge:
  //       AppStrings.interBlack(fontSize: 24.0).copyWith(color: Colors.black),
  //   displayMedium:
  //       AppStrings.interExtraBold(fontSize: 20.0).copyWith(color: Colors.black),
  //   displaySmall:
  //       AppStrings.interBold(fontSize: 18.0).copyWith(color: Colors.black),
  //   headlineLarge:
  //       AppStrings.interBold(fontSize: 20.0).copyWith(color: Colors.black),
  //   headlineMedium:
  //       AppStrings.interSemiBold(fontSize: 18.0).copyWith(color: Colors.black),
  //   headlineSmall:
  //       AppStrings.interBold(fontSize: 16.0).copyWith(color: Colors.black),
  //   titleLarge:
  //       AppStrings.interSemiBold(fontSize: 18.0).copyWith(color: Colors.black),
  //   titleMedium:
  //       AppStrings.interMedium(fontSize: 16.0).copyWith(color: Colors.black),
  // ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: MyColors.background,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: MyColors.primary,
    background: MyColors.background,
    onBackground: MyColors.onBackground,
  ),
  // textTheme: TextTheme(
  //   displayLarge: AppStrings.interBlack(fontSize: 24.0).copyWith(color: Colors.white),
  //   displayMedium:
  //       AppStrings.interExtraBold(fontSize: 20.0).copyWith(color: Colors.white),
  //   displaySmall:
  //       AppStrings.interBold(fontSize: 18.0).copyWith(color: Colors.white),
  //   headlineLarge:
  //       AppStrings.interBold(fontSize: 20.0).copyWith(color: Colors.white),
  //   headlineMedium:
  //       AppStrings.interSemiBold(fontSize: 18.0).copyWith(color: Colors.white),
  //   headlineSmall:
  //       AppStrings.interBold(fontSize: 16.0).copyWith(color: Colors.white),
  //   titleLarge:
  //       AppStrings.interSemiBold(fontSize: 18.0).copyWith(color: Colors.white),
  //   titleMedium:
  //       AppStrings.interMedium(fontSize: 16.0).copyWith(color: Colors.white),
  //   titleSmall:
  //       AppStrings.interRegular(fontSize: 14.0).copyWith(color: Colors.white),
  //   bodyLarge:
  //       AppStrings.interSemiBold(fontSize: 16.0).copyWith(color: Colors.white),
  //   bodyMedium:
  //       AppStrings.interMedium(fontSize: 14.0).copyWith(color: Colors.white),
  //   bodySmall:
  //       AppStrings.interRegular(fontSize: 12.0).copyWith(color: Colors.white),
  // ),
  checkboxTheme: CheckboxThemeData(
    checkColor: const WidgetStatePropertyAll(Colors.white),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(
          width: 1.5,
          color: MyColors.primary,
        );
      }
      return const BorderSide(
        width: 1.5,
        color: MyColors.onBackground,
      );
    }),
    fillColor:
        WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return MyColors.primary;
      }
      return Colors.transparent;
    }),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: MyColors.background,
    shadowColor: Colors.transparent,
    foregroundColor: MyColors.onBackground,
    surfaceTintColor: MyColors.background,
    centerTitle: true,
    titleTextStyle: GoogleFonts.montserrat(
      color: MyColors.onBackground,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
);
