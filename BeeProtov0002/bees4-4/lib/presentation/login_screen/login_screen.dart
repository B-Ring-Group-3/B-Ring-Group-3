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
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 30.h, top: 55.v, right: 30.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: _title(context)),
                      SizedBox(height: 50.v),
                      Center(child: _username(context)),
                      SizedBox(height: 30.v),
                      Center(child: _password(context)),
                      SizedBox(height: 55.v),
                      _login(context),
                      SizedBox(height: 25.v),
                      _register(context),
                      SizedBox(height: 5.v)
                    ]))));
  }

  Widget _title(BuildContext context) {
    return Column(children: [
      Container(
        decoration: AppDecoration.outlineBlack,
        child: Text(
          "The Bee Ring",
          style: theme.textTheme.displayMedium?.copyWith(
            shadows: [
              Shadow(
                color: Colors.black
                    .withOpacity(0.5), // Adjust opacity and color as needed
                offset: Offset(0, 2), // Adjust the offset based on your design
                blurRadius: 4, // Adjust the blur radius based on your design
              ),
            ],
          ),
        ),
      ),
      CustomImageView(
        //imagePath: ImageConstant.imgTwemojiHoneybee,
        imagePath: ImageConstant.imgBeeRingLogo,
        height: 125.v,
        width: 125.h,
        alignment: Alignment.center,
        //margin: EdgeInsets.only(left: 91.h)
      )
    ]);
  }

  Widget _username(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppDecoration.outlineBlack,
          child: Text(
            "Username",
            style: theme.textTheme.headlineLarge?.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black
                      .withOpacity(0.5), // Adjust opacity and color as needed
                  offset:
                      Offset(0, 2), // Adjust the offset based on your design
                  blurRadius: 4, // Adjust the blur radius based on your design
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: CustomTextFormField(
              controller: enterhereController,
              hintText: "enter here",
              autofocus: false,
            )),
      ],
    );
  }

  Widget _password(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppDecoration.outlineBlack,
          child: Text(
            "Password",
            style: theme.textTheme.headlineLarge?.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black
                      .withOpacity(0.5), // Adjust opacity and color as needed
                  offset:
                      Offset(0, 2), // Adjust the offset based on your design
                  blurRadius: 4, // Adjust the blur radius based on your design
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: CustomTextFormField(
              controller: enterhereController,
              hintText: "enter here",
              textInputAction: TextInputAction.done,
              autofocus: false,
            )),
      ],
    );
  }

  Widget _login(BuildContext context) {
    return CustomOutlinedButton(
      width: 161.h,
      text: "Login",
      onPressed: () {
        gotoDash(context);
      },
      alignment: Alignment.center,
    );
  }

  Widget _register(BuildContext context) {
    return CustomOutlinedButton(
      width: 145.h,
      text: "Register",
      buttonStyle: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFBF8C00))),
      buttonTextStyle: TextStyle(
        fontSize: 30,
        color: Color(0xFFFFFFFF)),
      onPressed: () {
        gotoDash(context);
      },
      alignment: Alignment.center,
    );
  }

  /// Navigates to the bRingDashScreen when the action is triggered.
  gotoDash(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoutes.bRingDashScreen);
  }
}
