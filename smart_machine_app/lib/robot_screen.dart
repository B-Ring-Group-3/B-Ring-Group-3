/// This is the screen that shows the resources available on a robot (or smart machine).
/// It takes in a Viam app client instance, as well as a robot client.
/// It then uses the Viam client instance to create a connection to that robot client.
/// Once the connection is established, you can view the resources available
/// and send commands to them.

import 'package:flutter/material.dart';
import 'package:viam_sdk/protos/app/app.dart';
import 'package:viam_sdk/viam_sdk.dart';


class RobotScreen extends StatefulWidget {
  final Viam _viam;
  final Robot robot;

  const RobotScreen(this._viam, this.robot, {super.key});

  @override
  State<RobotScreen> createState() => _RobotScreenState();
}

class _RobotScreenState extends State<RobotScreen> {
  /// Similar to previous screens, start with [_isLoading] to true.
  bool _isLoading = true;

  /// This is the [RobotClient], which allows you to access
  /// all the resources of a Viam Smart Machine.
  /// This differs from the [Robot] provided to us in the widget constructor
  /// in that the [RobotClient] contains a direct connection to the Smart Machine
  /// and its resources. The [Robot] object simply contains information about
  /// the Smart Machine, but is not actually connected to the machine itself.
  ///
  /// This is initialized late because it requires an asynchronous
  /// network call to establish the connection.
  late RobotClient client;

  @override
  void initState() {
    super.initState();
    // Call our own _initState method to initialize our state.
    _initState();
  }

  @override
  void dispose() {
    // You should always close the [RobotClient] to free up resources.
    // Calling [RobotClient.close] will clean up any tasks and
    // resources created by Viam.
    client.close();
    super.dispose();
  }

  /// This method will get called when the widget initializes its state.
  /// It exists outside the overridden [initState] function since it's async.
  Future<void> _initState() async {
    // Using the authenticated [Viam] the received as a parameter,
    // the app can obtain a connection to the Robot.
    // There is a helpful convenience method on the [Viam] instance for this.
    final robotClient = await widget._viam.getRobotClient(widget.robot);
    setState(() {
      client = robotClient;
      _isLoading = false;
    });
  }

  /// A computed variable that returns the available [ResourceName]s of
  /// this robot in an alphabetically sorted list.
  List<ResourceName> get _sortedResourceNames {
    return client.resourceNames..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.robot.name)),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.builder(
                itemCount: client.resourceNames.length,
                itemBuilder: (_, index) {
                  final resourceName = _sortedResourceNames[index];
                  return ListTile(
                    title: Text(resourceName.name),
                    subtitle: Text(
                        '${resourceName.namespace}:${resourceName.type}:${resourceName.subtype}'),
                  );
                }));
  }
}