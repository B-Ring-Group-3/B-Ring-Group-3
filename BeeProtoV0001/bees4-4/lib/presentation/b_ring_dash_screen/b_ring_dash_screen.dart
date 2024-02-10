import 'package:bees4/core/app_export.dart';
//import 'package:bees4/widgets/app_bar/appbar_leading_image.dart';
import 'package:bees4/widgets/app_bar/appbar_subtitle.dart';
//import 'package:bees4/widgets/app_bar/appbar_trailing_image.dart';
import 'package:bees4/widgets/app_bar/custom_app_bar.dart';
import 'package:bees4/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class BRingDashScreen extends StatelessWidget {
  const BRingDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 87.h, vertical: 4.v),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              _alerts(context),
              SizedBox(height: 8.v),
              _sensors(context),
              SizedBox(height: 3.v),
              _graphs(context),
              SizedBox(height: 5.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBack(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Row(
        children: [
          Spacer(),

          AppbarSubtitle(text: "Dashboard"),
          Spacer(),

          SizedBox(width: 20), // Add some spacing between title and dropdown
          DropdownMenuExample(), // Add the dropdown menu here
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildBack(BuildContext context) {
    return CustomElevatedButton(
      text: "Back",
      onPressed: () {
        gotoLogin(context);
      },
    );
  }

  Widget _alerts(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 35.h),
        child: Text(
          "Alerts",
          style: CustomTextStyles.headlineLargeBlack900.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color = Colors.black
                  .withOpacity(1), // Adjust the color and strokeWidth as needed
            shadows: [
              Shadow(
                color: Color(0xFFFFD233),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            //color: Color(0xFFFFD233),
          ),
        ),
      ),
      Container(
          height: 180.adaptSize,
          width: 180.adaptSize,
          padding: EdgeInsets.all(46.h),
          decoration: AppDecoration.fillBlack
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
          child: CustomImageView(
              imagePath: ImageConstant.imgWarning,
              height: 88.adaptSize,
              width: 88.adaptSize,
              alignment: Alignment.center,
              onTap: () {
                gotoAlerts(context);
              }))
    ]);
  }

  Widget _sensors(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Text(
          "Sensors",
          style: CustomTextStyles.headlineLargeBlack900.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color = Colors.black
                  .withOpacity(1), // Adjust the color and strokeWidth as needed
            shadows: [
              Shadow(
                color: Color(0xFFFFD233),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            //color: Color(0xFFFFD233),
          ),
        ),
      ),
      Container(
          height: 180.adaptSize,
          width: 180.adaptSize,
          padding: EdgeInsets.symmetric(horizontal: 45.h, vertical: 37.v),
          decoration: AppDecoration.outlineBlack900
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
          child: CustomImageView(
              imagePath: ImageConstant.imgVector,
              height: 105.v,
              width: 90.h,
              alignment: Alignment.center,
              onTap: () {
                gotoSensors(context);
              }))
    ]);
  }

  Widget _graphs(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 30.h),
        child: Text(
          "Graphs",
          style: CustomTextStyles.headlineLargeBlack900.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color = Colors.black
                  .withOpacity(1), // Adjust the color and strokeWidth as needed
            shadows: [
              Shadow(
                color: Color(0xFFFFD233),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            //color: Color(0xFFFFD233),
          ),
        ),
      ),
      SizedBox(height: 4.v),
      Container(
          height: 180.adaptSize,
          width: 180.adaptSize,
          padding: EdgeInsets.all(26.h),
          decoration: AppDecoration.fillBlack
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
          child: CustomImageView(
              imagePath: ImageConstant.imgIconDotted,
              height: 126.adaptSize,
              width: 126.adaptSize,
              alignment: Alignment.center,
              onTap: () {
                gotoGraphs(context);
              }))
    ]);
  }

  void gotoAlerts(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.alertPageScreen);
  }

  void gotoSensors(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sensorPageScreen);
  }

  void gotoGraphs(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.graphsPageScreen);
  }

  void gotoLogin(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoutes.loginScreen);
  }
}

const List<String> list = <String>['Hive 1', 'Hive 2', 'Hive 3', 'Add Hive'];

///class DropdownMenuApp extends StatelessWidget {
///  const DropdownMenuApp({super.key});

/// @override
/// Widget build(BuildContext context) {
///   return MaterialApp(
///   theme: ThemeData(useMaterial3: true),
///  home: Scaffold(
///    appBar: AppBar(title: const Text('DropdownMenu Sample')),
///    body: const Center(
///      child: DropdownMenuExample(),
///     ),
///    ),
///  );
/// }
///}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
