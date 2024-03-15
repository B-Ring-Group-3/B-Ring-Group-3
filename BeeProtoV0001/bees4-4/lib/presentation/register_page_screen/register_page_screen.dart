import 'package:bees4/core/app_export.dart';
import 'package:bees4/widgets/custom_outlined_button.dart';
import 'package:bees4/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController enterhereController = TextEditingController();
  TextEditingController enterhereController1 = TextEditingController();
  TextEditingController enterhereController2 = TextEditingController();

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
                      SizedBox(height: 25.v),
                      Center(child: _confirm(context)),
                      SizedBox(height: 40.v),
                      _submit(context),
                      SizedBox(height: 25.v),
                      _cancel(context),
                      SizedBox(height: 5.v)
                    ]))));
  }

  Widget _title(BuildContext context) {
    return Column(children: [
      Container(
        decoration: AppDecoration.outlineBlack,
        child: Text(
          "Register New Account",
          textAlign: TextAlign.center,
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
    ]);
  }

  Widget _username(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppDecoration.outlineBlack,
          child: Text(
            "New Username",
            style: theme.textTheme.headlineMedium?.copyWith(
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
            "New Password",
            style: theme.textTheme.headlineMedium?.copyWith(
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
              controller: enterhereController1,
              hintText: "enter here",
              autofocus: false,
            )),
      ],
    );
  }

  Widget _confirm(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppDecoration.outlineBlack,
          child: Text(
            "Confirm Password",
            style: theme.textTheme.headlineMedium?.copyWith(
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
              controller: enterhereController2,
              hintText: "enter here",
              textInputAction: TextInputAction.done,
              autofocus: false,
            )),
      ],
    );
  }

  Widget _submit(BuildContext context) {
    return CustomOutlinedButton(
      width: 161.h,
      text: "Submit",
      onPressed: () {
        gotoLogin(context);
      },
      alignment: Alignment.center,
    );
  }

  Widget _cancel(BuildContext context) {
    return CustomOutlinedButton(
      width: 145.h,
      text: "Cancel",
      buttonStyle: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFBF8C00))),
      buttonTextStyle: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
      onPressed: () {
        gotoLogin(context);
      },
      alignment: Alignment.center,
    );
  }

  /// Navigates to the login screen when the action is triggered.
  gotoLogin(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoutes.loginScreen);
  }
}
