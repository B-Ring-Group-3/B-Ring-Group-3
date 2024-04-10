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
//import 'package:viam_sdk/protos/service/data_manager.dart';

// Step 1: Import the viam_sdk
import 'package:viam_sdk/viam_sdk.dart';
//import 'package:viam_sdk/widgets.dart';

class GraphsPageScreen extends StatefulWidget {
  GraphsPageScreen({Key? key}) : super(key: key);

  @override
  _GraphsPageScreenState createState() => _GraphsPageScreenState();
}

int days = 1;
const List<int> day_range = <int>[1, 7, 30, 90, 180];

class _GraphsPageScreenState extends State<GraphsPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//class GraphsPageScreen extends StatelessWidget {
//  GraphsPageScreen({Key? key}) : super(key: key);
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _refreshData() async {
    setState(() {
      // Add any logic here to refresh the data
    });
  }

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
              _buildMiddle(context), // Add the new section here
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
              'Graph Settings',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontFamily: 'robotoBold',
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(
                          0.5), // Adjust opacity and color as needed
                      offset: Offset(
                          0, 2), // Adjust the offset based on your design
                      blurRadius:
                          4, // Adjust the blur radius based on your design
                    ),
                  ]),
            ),
          ),
          ListTile(
            title: Text('Export Data'),
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
      title: Row(
        children: [
          AppbarTitle(text: "Graphs"),
          Spacer(),
          _buildRangeSelect(context),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildMiddle(BuildContext context) {
    return Text("Displaying data from previous ${days} days.");
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

  int dropdownValue = day_range.first;
  Widget _buildRangeSelect(BuildContext context) {
    return DropdownMenu<int>(
      initialSelection: day_range.first,
      onSelected: (int? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          days = value;
        });
      },
      dropdownMenuEntries: day_range.map<DropdownMenuEntry<int>>((int value) {
        return DropdownMenuEntry<int>(
            value: value, label: value.toString() + " days");
      }).toList(),
    );
  }
}
