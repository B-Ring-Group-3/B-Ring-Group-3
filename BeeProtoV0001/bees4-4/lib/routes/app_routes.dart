import 'package:flutter/material.dart';
import 'package:bees4/presentation/login_screen/login_screen.dart';
import 'package:bees4/presentation/b_ring_dash_screen/b_ring_dash_screen.dart';
import 'package:bees4/presentation/sensor_page_screen/sensor_page_screen.dart';
import 'package:bees4/presentation/alert_page_screen/alert_page_screen.dart';
import 'package:bees4/presentation/graphs_page_screen/graphs_page_screen.dart';
import 'package:bees4/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:bees4/presentation/add_hive_screen/add_hive_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String bRingDashScreen = '/b_ring_dash_screen';

  static const String sensorPageScreen = '/sensor_page_screen';

  static const String alertPageScreen = '/alert_page_screen';

  static const String graphsPageScreen = '/graphs_page_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String addHiveScreen = '/add_hive_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    bRingDashScreen: (context) => BRingDashScreen(),
    sensorPageScreen: (context) => SensorPageScreen(),
    alertPageScreen: (context) => AlertPageScreen(),
    graphsPageScreen: (context) => GraphsPageScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    addHiveScreen: (context) => AddHiveScreen()
  };
}
