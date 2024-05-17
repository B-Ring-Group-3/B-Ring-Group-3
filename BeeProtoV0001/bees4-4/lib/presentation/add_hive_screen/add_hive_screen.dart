import 'package:flutter/material.dart';
import 'package:bees4/core/app_export.dart';
import 'package:bees4/auth_service.dart';

class AddHiveScreen extends StatefulWidget {
  const AddHiveScreen({Key? key}) : super(key: key);

  @override
  _AddHiveScreenState createState() => _AddHiveScreenState();
}

class _AddHiveScreenState extends State<AddHiveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _apiKeyIdController = TextEditingController();
  final _apiKeyController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Hive'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _hostController,
                decoration: InputDecoration(labelText: 'Host'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the host';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apiKeyIdController,
                decoration: InputDecoration(labelText: 'API Key ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the API key ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apiKeyController,
                decoration: InputDecoration(labelText: 'API Key'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the API key';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _authService.addRobot(
                      _hostController.text,
                      _apiKeyIdController.text,
                      _apiKeyController.text,
                    );
                    Navigator.popAndPushNamed(context, AppRoutes.bRingDashScreen);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
