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
import 'package:viam_sdk/protos/service/data_manager.dart';

// Step 1: Import the viam_sdk
import 'package:viam_sdk/viam_sdk.dart';
import 'package:viam_sdk/widgets.dart';



class GraphsPageScreen extends StatelessWidget {
  GraphsPageScreen({Key? key}) : super(key: key);
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
              _buildMiddle(context), // Add the new section here
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
            'Graph Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontFamily: 'robotoBold',
              shadows: [
              Shadow(
              color: Colors.black.withOpacity(0.5), // Adjust opacity and color as needed
              offset: Offset(0, 2), // Adjust the offset based on your design
              blurRadius: 4, // Adjust the blur radius based on your design
        ),
        ]
            ),
          ),
        ),
        ListTile(
          title: Text('Change Graph'),
          onTap: () {
            // Handle item 1 tap
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Edit Range'),
          onTap: () {
            // Handle item 2 tap
            Navigator.pop(context);
          },
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
      title: AppbarTitle(text: "Graphs"),
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

Widget _buildMiddle(BuildContext context) {
    return FutureBuilder(
      future: connectToViam(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // The connection is complete, you can access the result
          return Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Connected to Viam. Robot temp: ${snapshot.data}',
              
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        } else if (snapshot.hasError) {
          // If there's an error during the connection, handle it here
          return Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Error connecting to Viam: ${snapshot.error}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          // While the connection is in progress, show a loading indicator
          return CircularProgressIndicator();
        }
      },
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

// Step 2: Call this function from within your widget
Future<Map<String, dynamic>> connectToViam() async {
  
  const host = 'appdev1-main.v46c8jmy3x.viam.cloud';
  const apiKeyId = 'd8fc8e31-8cc0-45c6-9cc4-631a952d97af';
  const apiKey = '5yjnbxukpi671quprcbhu55qfjt00zp4';

  final robot = await RobotClient.atAddress(
    host,
    RobotClientOptions.withApiKey(apiKeyId, apiKey),
  );
  print("\n------------------Printing resources-----------------------\n");
  print(robot.resourceNames);
  
 // ResourceName robotPower =
//        ResourceName(namespace:'rdk', type:'component', subtype:'power_sensor', name:'solarChannel');
//print(robotPower);
Sensor temp = Sensor.fromRobot(robot, "temp");
Map<String, dynamic> tempReturnValue = await temp.readings(); // Await the result
print("temp get_readings return value: ");
print(tempReturnValue);

//var os = Sensor.fromRobot(robot, "os");
//var osReturnValue = await os.readings(); // Await the result
//print("os get_readings return value:" );
//print(osReturnValue);

//var solarChannel = PowerSensor.fromRobot(robot, "solarChannel");
//var solarChannelReturnValue = await solarChannel.power();
//print("solarChannel get_power return value: {solar_channel_return_value}");
//print(solarChannelReturnValue);


   // var boardConsumption = PowerSensor.fromRobot(robot, "boardConsumption");
   // var boardConsumptionReturnValue = await boardConsumption.power();
  //  print("boardConsumption get_power return value: {board_consumption_return_value}");
  //  print(boardConsumptionReturnValue);

  return tempReturnValue;
}
