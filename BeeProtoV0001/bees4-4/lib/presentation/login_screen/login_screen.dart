import 'package:bees4/core/app_export.dart';
import 'package:bees4/widgets/custom_outlined_button.dart';
import 'package:bees4/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';




// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController enterhereController = TextEditingController();

  TextEditingController enterhereController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.secondaryContainer,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 37.h, top: 65.v, right: 37.h),
                child: Column(children: [
        Container(
          decoration: AppDecoration.outlineBlack,
          child: Text(
          "The Bee Ring",
            style: theme.textTheme.displayMedium?.copyWith(
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

                  CustomImageView(
                      imagePath: ImageConstant.imgTwemojiHoneybee,
                      height: 103.v,
                      width: 109.h,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 91.h)),
                  SizedBox(height: 68.v),
          Container(
            decoration: AppDecoration.outlineBlack,
            child: Text(
            "Username",
              style: theme.textTheme.headlineLarge?.copyWith(
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
                  Padding(
                      padding: EdgeInsets.only(left: 28.h, right: 23.h),
                      child: CustomTextFormField(
                          controller: enterhereController,
                          hintText: "enter here")),
                  SizedBox(height: 68.v),
                  Container(
            decoration: AppDecoration.outlineBlack,
            child: Text(
            "Password",
              style: theme.textTheme.headlineLarge?.copyWith(
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
                  Padding(
                      padding: EdgeInsets.only(left: 28.h, right: 23.h),
                      child: CustomTextFormField(
                          controller: enterhereController1,
                          hintText: "enter here",
                          textInputAction: TextInputAction.done)),
                  SizedBox(height: 78.v),
                  CustomOutlinedButton(
                      width: 161.h,
                      text: "Login",
                      margin: EdgeInsets.only(left: 65.h),
                      onPressed: () {
                        gotoDash(context);
                      },
                      alignment: Alignment.centerLeft),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Navigates to the bRingDashScreen when the action is triggered.
  gotoDash(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoutes.bRingDashScreen);
  }
}


