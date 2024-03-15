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
import 'package:viam_sdk/protos/app/data.dart'; // Assuming Filter is defined here
// Step 1: Import the viam_sdk
import 'package:viam_sdk/viam_sdk.dart';
//import 'package:viam_sdk/widgets.dart';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:viam_sdk/src/gen/google/protobuf/any.pb.dart';
import 'package:viam_sdk/src/utils.dart';

class DataClient {
  final DataServiceClient _dataClient;
  final DataServiceClient _dataSyncClient;

  DataClient(this._dataClient, this._dataSyncClient);

  DataRequest _makeDataRequest(Filter? filter, int? limit, String? last, Order? sortOrder) {
    final dataRequest = DataRequest();
    dataRequest.filter = filter ?? Filter();
    if (limit != null) {
      dataRequest.limit = Int64(limit);
    }
    if (last != null) {
      dataRequest.last = last;
    }
    if (sortOrder != null) {
      dataRequest.sortOrder = sortOrder;
    }
    return dataRequest;
  }

  Future<TabularDataByFilterResponse> tabularDataByFilter({Filter? filter, int? limit, Order? sortOrder, countOnly = false}) async {
    if (countOnly) {
      final dataRequest = _makeDataRequest(filter, null, null, sortOrder);
      final request = TabularDataByFilterRequest()
        ..dataRequest = dataRequest
        ..countOnly = true;
      return await _dataClient.tabularDataByFilter(request);
    }

    final finalResponse = TabularDataByFilterResponse();
    limit ??= 1 << 32; // if no limit, set to max 32bit unsigned int

    while (finalResponse.count < limit) {
      final dataRequest = _makeDataRequest(filter, min(50, limit), finalResponse.last, sortOrder);
      final request = TabularDataByFilterRequest()
        ..dataRequest = dataRequest
        ..countOnly = false;

      final response = await _dataClient.tabularDataByFilter(request);

      if (response.count == 0) {
        break;
      }

      finalResponse.metadata.addAll(response.metadata);
      finalResponse.data.addAll(response.data);
      finalResponse.count += response.count;
      finalResponse.last = response.last;
    }

    return finalResponse;
  }

   /// Filter and download binary data
  /// If a [filter] is not provided, then all data will be returned.
  /// If a [limit] is provided, the data returned will contain at most that amount data. Otherwise, all data will be returned.
  Future<BinaryDataByFilterResponse> binaryDataByFilter({Filter? filter, int? limit, Order? sortOrder, countOnly = false}) async {
    if (countOnly) {
      final dataRequest = _makeDataRequest(filter, null, null, sortOrder);
      final request = BinaryDataByFilterRequest()
        ..dataRequest = dataRequest
        ..countOnly = true;
      return await _dataClient.binaryDataByFilter(request);
    }

    final finalResponse = BinaryDataByFilterResponse();
    limit ??= 1 << 32; // if no limit, set to max 32bit unsigned int

    while (finalResponse.count < limit) {
      final dataRequest = _makeDataRequest(filter, min(50, limit), finalResponse.last, sortOrder);
      final request = BinaryDataByFilterRequest()
        ..dataRequest = dataRequest
        ..countOnly = false;

      final response = await _dataClient.binaryDataByFilter(request);

      if (response.count == 0) {
        break;
      }

      finalResponse.data.addAll(response.data);
      finalResponse.count += response.count;
      finalResponse.last = response.last;
    }

    return finalResponse;
  }

}

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
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 56, width: double.maxFinite),
              _buildMiddle(context), // Add the new section here
              //Spacer(),
              _buildMiddle2(context), // Add the new section here
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

  Widget _buildMiddle2(BuildContext context) {
    return FutureBuilder(
      future: connectToViam2(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // The connection is complete, you can access the result
          return Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Connected to Viam. Robot Power: ${snapshot.data}',
              
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
  
  RobotClient robot;
  try {
    robot = await RobotClient.atAddress(
      host,
      RobotClientOptions.withApiKey(apiKeyId, apiKey),
    );
    print("\n------------------Printing resources-----------------------\n");
    print(robot.resourceNames);
    
    Sensor temp = Sensor.fromRobot(robot, "temp");
    Map<String, dynamic> tempReturnValue = await temp.readings(); // Await the result
    print("temp get_readings return value: ");
    print(tempReturnValue);

    
    //from viam.proto.app.data import Filter

//my_filter = Filter(component_name="left_motor")
    //tabular_data = await data_client.tabular_data_by_filter(my_filter)
    Filter myFilter = Filter(componentName: "temp");
    
    //TabularData tabularData = await ataClient.tabularDataByFilter("temp");

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
        print('Error closing robot connection (attempt ${attempts + 1}/$maxAttempts): $e');
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
    //print("\n------------------Printing resources-----------------------\n");
    //print(robot.resourceNames);
    
   // Sensor temp = Sensor.fromRobot(robot, "temp");
  //  Map<String, dynamic> tempReturnValue = await temp.readings(); // Await the result
  //  print("temp get_readings return value: ");
  //  print(tempReturnValue);

  //var os = Sensor.fromRobot(robot, "os");
//var osReturnValue = await os.readings(); // Await the result
//print("os get_readings return value:" );
//print(osReturnValue);

var solarChannel = PowerSensor.fromRobot(robot, "solarChannel");
double solarChannelReturnValue = await solarChannel.power();
print("solarChannel get_power return value: {solar_channel_return_value}");
print(solarChannelReturnValue);


   // var boardConsumption = PowerSensor.fromRobot(robot, "boardConsumption");
   // var boardConsumptionReturnValue = await boardConsumption.power();
  //  print("boardConsumption get_power return value: {board_consumption_return_value}");
  //  print(boardConsumptionReturnValue);

    // Attempt to close the connection with retry logic
    const int maxAttempts = 3;
    int attempts = 0;
    while (attempts < maxAttempts) {
      try {
        await robot.close();
        print('Robot connection closed successfully');
        break; // Exit the loop if close operation is successful
      } catch (e) {
        print('Error closing robot connection (attempt ${attempts + 1}/$maxAttempts): $e');
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


