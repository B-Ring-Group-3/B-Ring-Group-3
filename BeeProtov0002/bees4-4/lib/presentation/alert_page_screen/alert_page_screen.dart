import 'package:bees4/core/app_export.dart';
//import 'package:bees4/widgets/app_bar/appbar_leading_image.dart';
import 'package:bees4/widgets/app_bar/appbar_title.dart';
//import 'package:bees4/widgets/app_bar/appbar_trailing_image.dart';
import 'package:bees4/widgets/app_bar/custom_app_bar.dart';
import 'package:bees4/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Import the created search delegate
import 'package:bees4/core/utils/help_search_delegate.dart';


class AlertPageScreen extends StatelessWidget {
  AlertPageScreen({Key? key}) : super(key: key);
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 56, width: double.maxFinite),
              Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBack(context),
        drawer: _buildDrawer(context),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 210, 51, 1),
          ),
          child: Text(
            'Alert Settings',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'robotoBold',
              shadows: [
              Shadow(
              color: Colors.black.withOpacity(0.5), // Adjust opacity and color as needed
              offset: Offset(0, 2), // Adjust the offset based on your design
              blurRadius: 4, // Adjust the blur radius based on your design
        ),
        ],
              fontSize: 24.0,
            ),
          ),
        ),
        ListTile(
          title: Text('Alert Menu'),
          onTap: () {
            // Handle item 1 tap
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Notifications'),
          onTap: () {
            // Handle item 2 tap
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Alert Settings'),
          onTap: () {
            // Handle item 3 tap
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 46,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            '${ImageConstant.imgFrame1}',
            height: 24,
            width: 24,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Alerts"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: HelpSearchDelegate(),
              query: 'Search Help Pages',
            );
          },
        ),
      ],
      styleType: Style.bgFill,
    );
  }
  /// Section Widget
  Widget _buildBack(BuildContext context) {
    return CustomElevatedButton(
      text: "Back",
      onPressed: () {
        onBackPressed(context);
      },
    );
  }


  /// Navigates back to the previous screen.
  void onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }
}
