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
import 'package:fl_chart/fl_chart.dart';

class GraphsPageScreen extends StatefulWidget {
  GraphsPageScreen({Key? key}) : super(key: key);

  @override
  _GraphsPageScreenState createState() => _GraphsPageScreenState();
}

bool temp = true;
bool humid = true;
int days = 7;
const List<int> day_range = <int>[1, 7, 14, 30, 90, 180];

class _GraphsPageScreenState extends State<GraphsPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshData() async {
    setState(() {
      // Add any logic here to refresh the data
    });
  }

  List<FlSpot> chartData = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 10),
    FlSpot(3, 7),
    FlSpot(4, 12),
    FlSpot(5, 13),
    FlSpot(6, 17),
    FlSpot(7, 15),
    FlSpot(8, 20),
    FlSpot(9, 19),
    FlSpot(10, 16),
    FlSpot(11, 17),
    FlSpot(12, 15),
    FlSpot(13, 13),
  ];

  List<FlSpot> chartData2 = [
    FlSpot(0, 17),
    FlSpot(1, 18),
    FlSpot(2, 15),
    FlSpot(3, 14),
    FlSpot(4, 18),
    FlSpot(5, 16),
    FlSpot(6, 14),
    FlSpot(7, 11),
    FlSpot(8, 9),
    FlSpot(9, 10),
    FlSpot(10, 9),
    FlSpot(11, 8),
    FlSpot(12, 6),
    FlSpot(13, 7),
  ];

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
              _buildMiddle(context),
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
          Spacer(),
          AppbarTitle(text: "Graphs"),
          Spacer(),
          _buildRangeSelect(context),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildMiddle(BuildContext context) {
    return _buildGraph(context, temp, humid);
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

  Widget _buildGraph(BuildContext context, bool temp, bool humid) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: 300,
        child: LineChart(
          LineChartData(
              titlesData: FlTitlesData(
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: chartData.sublist(
                      chartData.length - days, chartData.length),
                  show: temp,
                  color: Colors.red,
                ),
                LineChartBarData(
                  spots: chartData2.sublist(
                      chartData2.length - days, chartData2.length),
                  show: humid,
                  color: Colors.blue,
                ),
              ]),
        ),
      ),
    );
  }

  int dropdownValue = day_range[1];
  Widget _buildRangeSelect(BuildContext context) {
    return DropdownMenu<int>(
      initialSelection: day_range[1],
      onSelected: (int? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          if (value > chartData.length) {
            days = chartData.length;
          } else {
            days = value;
          }
        });
      },
      dropdownMenuEntries: day_range.map<DropdownMenuEntry<int>>((int value) {
        return DropdownMenuEntry<int>(
            value: value, label: value.toString() + " days");
      }).toList(),
    );
  }
}

// Step 2: Call this function from within your widget
Future<Map<String, dynamic>> connectToViam() async {
  const host = 'appdev1-main.v46c8jmy3x.viam.cloud';
  const apiKeyId = 'd8fc8e31-8cc0-45c6-9cc4-631a952d97af';
  const apiKey = '5yjnbxukpi671quprcbhu55qfjt00zp4';

  RobotClient robot;
  try {
    robot = await RobotClient.atAddress(
      host,
      RobotClientOptions.withApiKey(apiKeyId, apiKey),
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
  const apiKeyId = 'd8fc8e31-8cc0-45c6-9cc4-631a952d97af';
  const apiKey = '5yjnbxukpi671quprcbhu55qfjt00zp4';

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
