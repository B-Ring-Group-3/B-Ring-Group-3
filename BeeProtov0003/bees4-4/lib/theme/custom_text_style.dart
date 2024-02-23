import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Display text style
  static get displayMediumPrimary => theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get displayMediumRegular => theme.textTheme.displayMedium!.copyWith(
        fontSize: 40.fSize,
        fontWeight: FontWeight.w400,
      );
  // Headline text style
  static get headlineLargeBlack900 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.blueGray100,
      );
}

//extension on TextStyle {
//  TextStyle get roboto {
//    return copyWith(
//      fontFamily: 'Roboto',
//    );
//  }//
//}
