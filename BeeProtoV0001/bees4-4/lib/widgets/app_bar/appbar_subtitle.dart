import 'package:bees4/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarSubtitle extends StatelessWidget {
  AppbarSubtitle({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!.call() : null,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Container(
          decoration: AppDecoration.outlineBlack,
          child: Text(
            text,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.onPrimaryContainer, 
              shadows: [
              Shadow(
              color: Colors.black.withOpacity(0.5), // Adjust opacity and color as needed
              offset: Offset(0, 2), // Adjust the offset based on your design
              blurRadius: 4, // Adjust the blur radius based on your design
        ),
      ],
            ),
          ),
        ),
      ),
    );
  }
}
