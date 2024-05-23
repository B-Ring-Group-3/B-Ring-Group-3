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
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:bees4/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Step 1: Import the viam_sdk
import 'package:viam_sdk/viam_sdk.dart';
//import 'package:viam_sdk/widgets.dart';

class SensorPageScreen extends StatefulWidget {
  SensorPageScreen({Key? key}) : super(key: key);

  @override
  _SensorPageScreenState createState() => _SensorPageScreenState();
}

class _SensorPageScreenState extends State<SensorPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //final FirestoreService _firestoreService = FirestoreService();

//class SensorPageScreen extends StatelessWidget {
//SensorPageScreen({Key? key}) : super(key: key);
//final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
              _buildSensorInfo(context, 'Robot Temp and Humidity', connectToViam), // Add the new section here
              SizedBox(height: 20),
              _buildSensorInfo(context, 'Robot Power', connectToViam2), // Add the new section here
            ],
          ),
        ),
        drawer: _buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: _refreshData,
          tooltip: 'Refresh',
          child: Icon(Icons.refresh),
        ),
        bottomNavigationBar: _buildBack(context),
      ),
    );
  }

  Widget _buildSensorInfo(BuildContext context, String title, Function() connectFunction) {
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
          double power = 0.0;

          if (title == 'Robot Temp and Humidity') {
            Map<String, dynamic> sensorDataTempHum = snapshot.data as Map<String, dynamic>;
            temperature = sensorDataTempHum["temperature_celsius"] ?? 0.0;
            humidity = double.parse((sensorDataTempHum["relative_humidity_pct"] ?? 0.0).toStringAsFixed(2));

          } else if (title == 'Robot Power') {
            double sensorDataHum = snapshot.data as double;
            power = double.parse(sensorDataHum.toStringAsFixed(2));
            power *= 100;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               // if(title == "Robot Power")
                Text(
                  title,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Display temperature and humidity if title is 'Robot Temp'
                if (title == 'Robot Temp and Humidity') ...[
                  Text(
                    'Temperature:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '${temperature.toStringAsFixed(2)} °C',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Humidity:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '$humidity %',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
                // Display power if title is 'Robot Power'
                if (title == 'Robot Power') ...[
                  Text(
                    'Power:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '$power %',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ],
            ),
          );
        }
      },
    );
  }


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
              'Sensor Options',
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
            title: Text('Sensor 1'),
            onTap: () {
              // Handle item 1 tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Sensor 2'),
            onTap: () {
              // Handle item 2 tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Sensor 3'),
            onTap: () {
              // Handle item 3 tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Sensor Settings'),
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
      title: AppbarTitle(text: "Sensors"),
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

// Step 2: Call this function from within your widget
Future<Map<String, dynamic>> connectToViam() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('No user signed in.');
  }

  DocumentSnapshot robotDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('robots')
      .doc('robot')
      .get();

  if (!robotDoc.exists) {
    throw Exception('Robot data not found for user ${user.uid}');
  }

  Map<String, dynamic> robotData = robotDoc.data() as Map<String, dynamic>;
  final host = robotData['host'];
  final apiKeyId = robotData['apiKeyId'];
  final apiKey = robotData['apiKey'];

  RobotClient robot;
  try {
    robot = await RobotClient.atAddress(host, RobotClientOptions.withApiKey(apiKeyId, apiKey));
    Sensor temp = Sensor.fromRobot(robot, "temp");
    Map<String, dynamic> tempReturnValue = await temp.readings();
    double temperature = tempReturnValue["temperature_celsius"] ?? 0.0;

    // Now, instead of adding the temperature to the robot document, add it to the temperatures collection
    var temperatureDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('robots')
        .doc('robot')
        .collection('temperatures')
        .doc();  // Firestore generates a unique ID for each temperature record

    await temperatureDocRef.set({
      'temperature_celsius': temperature,
      'timestamp': FieldValue.serverTimestamp()  // Use server timestamp to ensure consistency
    });

    // Close the robot connection
    try {
      await robot.close();
    } catch (e) {
      print('Error closing robot connection: $e');
    }

    return tempReturnValue;
  } catch (e) {
    print("Error connecting to Viam: $e");
    throw e;
  }
}


Future<double> connectToViam2() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('No user signed in.');
  }

  DocumentSnapshot robotDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('robots')
      .doc('robot')
      .get();

  if (!robotDoc.exists) {
    throw Exception('Robot data not found for user ${user.uid}');
  }

  Map<String, dynamic> robotData = robotDoc.data() as Map<String, dynamic>;

  final host = robotData['host'];
  final apiKeyId = robotData['apiKeyId'];
  final apiKey = robotData['apiKey'];

  await Future.delayed(Duration(seconds: 5));
  RobotClient robot;
  try {
    robot = await RobotClient.atAddress(
      host,
      RobotClientOptions.withApiKey(apiKeyId, apiKey),
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
            'Error closing robot connection (attempt ${attempts + 1}/$maxAttempts): $e');
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


// Widget _buildMiddle(BuildContext context) {
//     return FutureBuilder(
//       future: connectToViam(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           // The connection is complete, you can access the result
//           return Container(
//             color: Colors.blue,
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Connected to Viam. Robot temp: ${snapshot.data}',
//
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           // If there's an error during the connection, handle it here
//           return Container(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Error connecting to Viam: ${snapshot.error}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           );
//         } else {
//           // While the connection is in progress, show a loading indicator
//           return Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.all(16),
//               child: CircularProgressIndicator()
//           );
//           // return CircularProgressIndicator();
//         }
//       },
//     );
//   }
//
//   Widget _buildMiddle2(BuildContext context) {
//     return FutureBuilder(
//       future: connectToViam2(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           // The connection is complete, you can access the result
//           return Container(
//             color: Colors.red,
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Connected to Viam. Robot Power: ${snapshot.data}',
//
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           // If there's an error during the connection, handle it here
//           return Container(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Error connecting to Viam: ${snapshot.error}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           );
//         } else {
//           // While the connection is in progress, show a loading indicator
//           return Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.all(16),
//               child: CircularProgressIndicator()
//           );
//           // return CircularProgressIndicator();
//         }
//       },
//     );
//   }

