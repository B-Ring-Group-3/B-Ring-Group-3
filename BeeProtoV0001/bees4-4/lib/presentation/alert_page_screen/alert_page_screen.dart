import 'package:bees4/core/app_export.dart';
import 'package:bees4/widgets/app_bar/appbar_title.dart';
import 'package:bees4/widgets/app_bar/custom_app_bar.dart';
import 'package:bees4/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Import the created search delegate
import 'package:bees4/core/utils/help_search_delegate.dart';
import 'package:bees4/env.dart';
// Import the viam_sdk
import 'package:viam_sdk/viam_sdk.dart';

// The alert page connects to viam and gets the bots readings, and displays alert messages
// based on values defined below. This page does not store this data and operates only on most 
// recent smart device readings. Ideally this code would run on a timer and disaply an alert on the 
// dash screen as a smaller icon over the alerts page icon button 

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
// This widget build the alert page itself. Widgets that build page elements 
// are inserted here
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
              _buildTitle('Generating Potential Alerts...'),
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
// This widget builds the alert info by connecting to viam through connectFunction
// and passing returned data that formats it into cards
  Widget _buildAlertInfo(BuildContext context, String title, Function() connectFunction) {
  return FutureBuilder(
    future: connectFunction(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        Map<String, dynamic> sensorDataTempHum = snapshot.data as Map<String, dynamic>;
        double temperature = sensorDataTempHum["temperature_celsius"] ?? 0.0;
        double humidity = sensorDataTempHum["relative_humidity_pct"] ?? 0.0;

        List<Widget> alerts = [];

        if (temperature > TEMP_UPPER_LIMIT) {
          alerts.add(_buildAlertCard('Temperature is too high at ${temperature.toStringAsFixed(2)}°C.'));
        }
        if (temperature < TEMP_LOWER_LIMIT) {
          alerts.add(_buildAlertCard('Temperature is too low at ${temperature.toStringAsFixed(2)}°C.'));
        }
        if (humidity > HUMID_UPPER_LIMIT) {
          alerts.add(_buildAlertCard('Humidity is too high at ${humidity.toStringAsFixed(2)}%.'));
        }
        if (humidity < HUMID_LOWER_LIMIT) {
          alerts.add(_buildAlertCard('Humidity is too low at ${humidity.toStringAsFixed(2)}%.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Alerts for $title',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ...alerts,
          ],
        );
      }
    },
  );
}
// These cards make the data look nice
Widget _buildAlertCard(String alertText) {
  // Adjust the regular expression to exclude the period after the numeric value
  RegExp exp = RegExp(r'(\d+\.\d+)(°C|%)');
  var match = exp.firstMatch(alertText);

  String boldPart = '';
  String normalPart = alertText;

  if (match != null) {
    boldPart = match[0] ?? ''; // The temperature/humidity value and unit
    // Extract index of the match to properly split the string without a trailing period
    int matchIndex = alertText.indexOf(match[0]!);
    normalPart = alertText.substring(0, matchIndex); // Exclude the number from normal part
  }

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: ListTile(
      title: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16), // Default text style
          children: [
            TextSpan(text: normalPart), // Non-bold part of the text
            TextSpan(
              text: boldPart,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red), // Bold part
            ),
          ],
        ),
      ),
      leading: Icon(Icons.warning, color: Colors.red),
    ),
  );
}


// These cards make the data look nice
Widget _buildTitle(String title) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),  // Adjusted margin for horizontal alignment
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 255, 210, 64),
      borderRadius: BorderRadius.circular(0),  // Adjusted for full-width
    ),
    width: double.infinity,  // Ensures the container takes full width
    child: Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

// This widget build the app drawer for future settings 
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

  /// Top main appbar Widget
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

  /// Back button Widget
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

// Call this function from within your widget to connectToViam
Future<Map<String, dynamic>> connectToViam() async {
  const host = 'appdev1-main.v46c8jmy3x.viam.cloud';

  // Key obfuscation is provided through envied package. https://pub.dev/packages/envied
  // Keys are provided as comments here for transparency in how the code works
  // but should be removed from a production app
  String theApiKeyId = Env.apiKeyId;  //'d8fc8e31-8cc0-45c6-9cc4-631a952d97af';
  String theApiKey = Env.apiKey;  //'5yjnbxukpi671quprcbhu55qfjt00zp4';


  RobotClient robot;

  // The try-retry-retry-catch eventually logic is there to handle inconsistant connection to the 
  // bot

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
