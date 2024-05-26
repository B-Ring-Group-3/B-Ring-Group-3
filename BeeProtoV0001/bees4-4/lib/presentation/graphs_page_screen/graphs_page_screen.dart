import 'package:bees4/core/app_export.dart';
//import 'package:bees4/widgets/app_bar/appbar_leading_image.dart';
import 'package:bees4/widgets/app_bar/appbar_title.dart';
//import 'package:bees4/widgets/app_bar/appbar_trailing_image.dart';
import 'package:bees4/widgets/app_bar/custom_app_bar.dart';
import 'package:bees4/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Import the created search delegate
//import 'package:bees4/core/utils/help_search_delegate.dart';
//import 'package:viam_sdk/protos/service/data_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:bees4/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';


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
List<FlSpot> chartData = [];

class _GraphsPageScreenState extends State<GraphsPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshData() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('robots')
      .doc('robot') // Assuming 'robot' is the ID of the specific robot
      .collection('sensorData')
      .orderBy('timestamp', descending: true)
      .limit(180)
      .get();

    if (snapshot.docs.isEmpty) {
      print('No data found.');
    } else {
      List<FlSpot> newTempData = [];
      List<FlSpot> newHumidData = [];
      int index = 0;
      for (var doc in snapshot.docs) {
        var data = doc.data();
        if (data is Map<String, dynamic>) {
          double temp = (data['temperature_celsius'] as num?)?.toDouble() ?? 0.0;
          double humid = (data['humidity_percent'] as num?)?.toDouble() ?? 0.0;
          newTempData.add(FlSpot(index.toDouble(), temp));
          newHumidData.add(FlSpot(index.toDouble(), humid));
          print('Index: $index, Temperature: $temp, Humidity: $humid');
        }
        index++;
      }
      print('Total data points fetched: ${newTempData.length}'); // Logging total points

      setState(() {
        tempData = newTempData;
        humidData = newHumidData;
      });
    }
  } else {
    print('No user signed in.');
  }
}



  List<FlSpot> tempData = [
    FlSpot(0, 65),
    FlSpot(1, 62),
    FlSpot(2, 58),
    FlSpot(3, 57),
    FlSpot(4, 58),
    FlSpot(5, 56),
    FlSpot(6, 57),
    FlSpot(7, 59),
    FlSpot(8, 62),
    FlSpot(9, 66),
    FlSpot(10, 65),
    FlSpot(11, 68),
    FlSpot(12, 72),
    FlSpot(13, 71),
  ];

  List<FlSpot> humidData = [
    FlSpot(0, 61),
    FlSpot(1, 60.5),
    FlSpot(2, 60),
    FlSpot(3, 61),
    FlSpot(4, 62),
    FlSpot(5, 60),
    FlSpot(6, 58.5),
    FlSpot(7, 59),
    FlSpot(8, 59.5),
    FlSpot(9, 60.5),
    FlSpot(10, 60),
    FlSpot(11, 61),
    FlSpot(12, 59),
    FlSpot(13, 63),
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
        floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _tempButton(context),
            _humidButton(context)
          ]
        ),
        SizedBox(height: 20),
        _buildGraph(context, temp, humid),
      ],
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

  Widget _tempButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          temp = !temp;
        });
      },
      style: OutlinedButton.styleFrom(
          foregroundColor: temp ? Colors.white : Colors.black,
          backgroundColor: temp ? Colors.red : Colors.transparent,
          side: BorderSide(
            color: appTheme.black900,
            width: 2.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.all(26),
          textStyle: TextStyle(
            fontSize: 20,
          )
        ),
      child: Text("Temperature"),
    );
  }

  Widget _humidButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          humid = !humid;
        });
      },
      style: OutlinedButton.styleFrom(
          foregroundColor: humid ? Colors.white : Colors.black,
          backgroundColor: humid ? Colors.blue : Colors.transparent,
          side: BorderSide(
            color: appTheme.black900,
            width: 2.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.all(26),
          textStyle: TextStyle(
            fontSize: 20,
          )
        ),
      child: Text("Humidity"),
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
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            if (temp) LineChartBarData(
              spots: tempData.sublist(max(0, tempData.length - days), tempData.length),
              show: temp,
              color: Colors.red,
              isCurved: true,
            ),
            if (humid) LineChartBarData(
              spots: humidData.sublist(max(0, humidData.length - days), humidData.length),
              show: humid,
              color: Colors.blue,
              isCurved: true,
            ),
          ],
        ),
      ),
    ),
  );
}


  int dropdownValue = day_range[1];
  
  Widget _buildRangeSelect(BuildContext context) {
  return DropdownButton<int>(
    value: dropdownValue,
    onChanged: (int? newValue) {
      if (newValue != null) {
        setState(() {
          dropdownValue = newValue;
          days = newValue;
          print("Dropdown selected: $days days");
        });
      }
    },
    items: day_range.map<DropdownMenuItem<int>>((int value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text('$value days'),
      );
    }).toList(),
  );
}
}