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
import 'package:bees4/env.dart';
// Step 1: Import the viam_sdk
import 'package:viam_sdk/viam_sdk.dart';

// Global const values for thresholds at which an alert will be issued.
// These values are based on information from this website:
// https://www.bee-mindful.com/post/2020/08/03/pros-and-cons-of-helping-bees-with-temperature-and-humidity-control-within-the-hive#:~:text=On%20the%20other%20hand%2C%20bees,will%20prevent%20healthy%20brood%20rearing.
const double TEMP_UPPER_LIMIT = 35.5;
const double TEMP_LOWER_LIMIT = 32.0;
const double HUMID_UPPER_LIMIT = 60.0;
const double HUMID_LOWER_LIMIT = 50.0;

class AlertPageScreen extends StatefulWidget {
  AlertPageScreen({Key? key}) : super(key: key);

  @override
  _AlertPageScreenState createState() => _AlertPageScreenState();
}

class _AlertPageScreenState extends State<AlertPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method to refresh the data
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildAlertInfo(context, 'Robot Temp and Humidity', connectToViam), // Add the new section here
            ],
          ),
        ),
        bottomNavigationBar: _buildBack(context),
        drawer: _buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: _refreshData,
          tooltip: 'Refresh',
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget _buildAlertInfo(BuildContext context, String title, Function() connectFunction) {
    return FutureBuilder(
      future: connectFunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // Extract data based on the title
          double temperature = 0.0;
          double humidity = 0.0;

          if (title == 'Robot Temp and Humidity') {
            Map<String, dynamic> sensorDataTempHum = snapshot.data as Map<String, dynamic>;
            temperature = double.parse((sensorDataTempHum["temperature_celsius"] ?? 0.0).toStringAsFixed(2));
            humidity = double.parse((sensorDataTempHum["relative_humidity_pct"] ?? 0.0).toStringAsFixed(2));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // Display temperature and humidity if title is 'Robot Temp'
                if (title == 'Robot Temp and Humidity') ...[
                  if (temperature.toDouble() > TEMP_UPPER_LIMIT)
                    Text(
                      'ALERT: Temperature is at $temperature °C. This is too high!',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  if (temperature.toDouble() < TEMP_LOWER_LIMIT)
                    Text(
                      'ALERT: Temperature is at $temperature °C. This is too low!',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  SizedBox(height: 10),
                  if (humidity.toDouble() > HUMID_UPPER_LIMIT)
                    Text(
                      'ALERT: Humidity is at $humidity%. This is too high!',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  if (humidity.toDouble() < HUMID_LOWER_LIMIT)
                    Text(
                      'ALERT: Humidity is at $humidity%. This is too low!',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                ],
              ],
            ),
          );
        }
      },
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
                    color: Colors.black
                        .withOpacity(0.5), // Adjust opacity and color as needed
                    offset:
                        Offset(0, 2), // Adjust the offset based on your design
                    blurRadius:
                        4, // Adjust the blur radius based on your design
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

// Step 2: Call this function from within your widget
Future<Map<String, dynamic>> connectToViam() async {
  const host = 'appdev1-main.v46c8jmy3x.viam.cloud';
  String theApiKeyId = Env.apiKeyId;  //'d8fc8e31-8cc0-45c6-9cc4-631a952d97af';
  String theApiKey = Env.apiKey;  //'5yjnbxukpi671quprcbhu55qfjt00zp4';


  RobotClient robot;
  try {
    robot = await RobotClient.atAddress(
      host,
      RobotClientOptions.withApiKey(theApiKeyId, theApiKey),
    );
    print("\n------------------Printing resources-----------------------\n");
    print(robot.resourceNames);

    Sensor temp = Sensor.fromRobot(robot, "temp");
    Map<String, dynamic> tempReturnValue =
      await temp.readings(); // Await the result
    print("temp get_readings return value: ");
    print(tempReturnValue);

    // Attempt to close the connection with retry logic
    const int maxAttempts = 3;
    int attempts = 0;
    while (attempts < maxAttempts) {
      try {
        await robot.close();
        await Future.delayed(Duration(seconds: 5));
        print('Next information-->');
        break; // Exit the loop if close operation is successful
      } catch (e) {
        print(
            'Error closing robot connection (attempt ${attempts + 1}/$maxAttempts): $e');
        attempts++; // Increment attempts counter
        await Future.delayed(Duration(seconds: 1)); // Delay before retrying
      }
    }

    return tempReturnValue;
  } catch (e) {
    print("Error connecting to Viam: $e");
    throw e; // Re-throw the error to be handled by the caller
  }
}

Future<double> connectToViam2() async {
  const host = 'appdev1-main.v46c8jmy3x.viam.cloud';
  String theApiKeyId = Env.apiKeyId;  //'d8fc8e31-8cc0-45c6-9cc4-631a952d97af';
  String theApiKey = Env.apiKey;  //'5yjnbxukpi671quprcbhu55qfjt00zp4';

  await Future.delayed(Duration(seconds: 5));
  RobotClient robot;
  try {
    robot = await RobotClient.atAddress(
      host,
      RobotClientOptions.withApiKey(theApiKeyId, theApiKey),
    );

    var solarChannel = PowerSensor.fromRobot(robot, "solarChannel");
    double solarChannelReturnValue = await solarChannel.power();
    print("solarChannel get_power return value: {solar_channel_return_value}");
    print(solarChannelReturnValue);

    // Attempt to close the connection with retry logic
    const int maxAttempts = 3;
    int attempts = 0;
    while (attempts < maxAttempts) {
      try {
        await robot.close();
        print('Robot connection closed successfully');
        break; // Exit the loop if close operation is successful
      } catch (e) {
        print(
            'Error closing robot connection (attempt ${attempts +
                1}/$maxAttempts): $e');
        attempts++; // Increment attempts counter
        await Future.delayed(Duration(seconds: 1)); // Delay before retrying
      }
    }

    return solarChannelReturnValue;
  } catch (e) {
    print("Error connecting to Viam: $e");
    throw e; // Re-throw the error to be handled by the caller
  }
}
