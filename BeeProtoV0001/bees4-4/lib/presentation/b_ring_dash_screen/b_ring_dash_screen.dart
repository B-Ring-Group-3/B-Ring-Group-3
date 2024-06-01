import 'package:bees4/core/app_export.dart';
//import 'package:bees4/widgets/app_bar/appbar_leading_image.dart';
import 'package:bees4/widgets/app_bar/appbar_subtitle.dart';
//import 'package:bees4/widgets/app_bar/appbar_trailing_image.dart';
import 'package:bees4/widgets/app_bar/custom_app_bar.dart';
import 'package:bees4/widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BRingDashScreen extends StatefulWidget {
  const BRingDashScreen({Key? key}) : super(key: key);

  @override
  _BRingDashScreenState createState() => _BRingDashScreenState();
}

class _BRingDashScreenState extends State<BRingDashScreen> with RouteAware {
  bool hasRobot = false;

  @override
  void initState() {
    super.initState();
    _checkRobotStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void didPopNext() {
    _checkRobotStatus();
  }

  Future<void> _checkRobotStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot robotSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('robots')
          .get();

      if (robotSnapshot.docs.isNotEmpty) {
        setState(() {
          hasRobot = true;
        });
      } else {
        setState(() {
          hasRobot = false;
        });
        _showNoRobotPopup();
      }
    }
  }

  void _showNoRobotPopup() {
    WidgetsBinding.instance..addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No Robot Found'),
          content: Text('You currently have no robots connected. Please add a hive.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    RouteObserver<PageRoute>().unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 4.v),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Center(child: _alerts(context)),
              Center(child: SizedBox(height: 8.v)),
              Center(child: _sensors(context)),
              Center(child: SizedBox(height: 5.v)),
              Center(child: _graphs(context)),
              Center(child: SizedBox(height: 5.v))
            ],
          )
        ),
        bottomNavigationBar: _buildBack(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Row(
        children: [
          Spacer(),

          AppbarSubtitle(text: "Dashboard"),
          Spacer(),

          SizedBox(width: 20), // Add some spacing between title and dropdown
          _buildHiveButtonOrLabel(), // Add the dropdown menu here
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildHiveButtonOrLabel() {
    if (hasRobot) {
      return Text(
        'Connected',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addHiveScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow, // Background color
          foregroundColor: Colors.black, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding inside the button
          textStyle: TextStyle(
            fontSize: 16, // Text size
            fontWeight: FontWeight.bold, // Text weight
          ),
        ),
        child: Text('Add Hive'),
      );
    }
  }

  Widget _buildBack(BuildContext context) {
    return CustomElevatedButton(
        text: "Sign Out",
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
        },
    );
  }

  Widget _alerts(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 35.h),
        child: Text(
          "Alerts",
          style: CustomTextStyles.headlineLargeBlack900.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color = Colors.black
                  .withOpacity(1), // Adjust the color and strokeWidth as needed
            shadows: [
              Shadow(
                color: Color(0xFFFFD233),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            //color: Color(0xFFFFD233),
          ),
        ),
      ),
      InkWell(
        child: Container(
          height: 180.adaptSize,
          width: 180.adaptSize,
          padding: EdgeInsets.all(46.h),
          decoration: AppDecoration.outlineBlack900
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
          child: CustomImageView(
              imagePath: ImageConstant.imgWarning,
              height: 88.adaptSize,
              width: 88.adaptSize,
              alignment: Alignment.center,
            )
          ),
        onTap: () { gotoAlerts(context); }
      )
    ]);
  }

  Widget _sensors(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Text(
          "Sensors",
          style: CustomTextStyles.headlineLargeBlack900.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color = Colors.black
                  .withOpacity(1), // Adjust the color and strokeWidth as needed
            shadows: [
              Shadow(
                color: Color(0xFFFFD233),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            //color: Color(0xFFFFD233),
          ),
        ),
      ),
      InkWell(
        child: Container(
          height: 180.adaptSize,
          width: 180.adaptSize,
          padding: EdgeInsets.symmetric(horizontal: 45.h, vertical: 37.v),
          decoration: AppDecoration.outlineBlack900
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
          child: CustomImageView(
              imagePath: ImageConstant.imgVector,
              height: 105.v,
              width: 90.h,
              alignment: Alignment.center,
            )
          ),
        onTap: () { gotoSensors(context); }
      )
    ]);
  }

  Widget _graphs(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 30.h),
        child: Text(
          "Graphs",
          style: CustomTextStyles.headlineLargeBlack900.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color = Colors.black
                  .withOpacity(1), // Adjust the color and strokeWidth as needed
            shadows: [
              Shadow(
                color: Color(0xFFFFD233),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
            //color: Color(0xFFFFD233),
          ),
        ),
      ),
      SizedBox(height: 4.v),
      InkWell(
        child: Container(
          height: 180.adaptSize,
          width: 180.adaptSize,
          padding: EdgeInsets.all(26.h),
          decoration: AppDecoration.outlineBlack900
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
          child: CustomImageView(
            imagePath: ImageConstant.imgIconDotted,
            height: 126.adaptSize,
            width: 126.adaptSize,
            alignment: Alignment.center,
          )),
        onTap: () { gotoGraphs(context); },
      )
    ]);
  }

  void gotoAlerts(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.alertPageScreen);
  }

  void gotoSensors(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sensorPageScreen);
  }

  void gotoGraphs(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.graphsPageScreen);
  }

  void gotoLogin(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoutes.loginScreen);
  }
}



///class DropdownMenuApp extends StatelessWidget {
///  const DropdownMenuApp({super.key});

/// @override
/// Widget build(BuildContext context) {
///   return MaterialApp(
///   theme: ThemeData(useMaterial3: true),
///  home: Scaffold(
///    appBar: AppBar(title: const Text('DropdownMenu Sample')),
///    body: const Center(
///      child: DropdownMenuExample(),
///     ),
///    ),
///  );
/// }
///}
///
/*const List<String> list = <String>['Hive 1', 'Hive 2', 'Hive 3', 'Add Hive'];

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? dropdownValue;
  late Stream<QuerySnapshot> _robotStream;

  @override
  void initState() {
    super.initState();
    _robotStream = _getRobotStream();
  }

  Stream<QuerySnapshot> _getRobotStream() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('robots')
          .snapshots();
    }
    return const Stream.empty();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _robotStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<String> hives = snapshot.data!.docs.map((doc) {
          return 'Hive ${doc.id}';
        }).toList();

        hives.add('Add Hive');

        return DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value;
            });
            if (value == 'Add Hive') {
              Navigator.pushNamed(context, AppRoutes.addHiveScreen);
            }
          },
          items: hives.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }*/

