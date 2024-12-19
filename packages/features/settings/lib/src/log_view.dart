
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sms_setting.dart';


class LogViewScreen extends StatefulWidget {
  const LogViewScreen({super.key});

  @override
  LogViewScreenState createState() => LogViewScreenState();
}

class LogViewScreenState extends State<LogViewScreen> {
  bool _enableIcareSMS = false;
  String _phoneNumber = '';
  String _serverUrl = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load saved preferences
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _enableIcareSMS = prefs.getBool('enableIcareSMS') ?? false;
      _phoneNumber = prefs.getString('phoneNumber') ?? '';
      _serverUrl = prefs.getString('serveUrl') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = _enableIcareSMS && _phoneNumber.isNotEmpty
        ? 'IcareSMS running ($_phoneNumber)'
        : 'IcareSMS disabled';
    String subtitle = _enableIcareSMS && _phoneNumber.isNotEmpty
        ? 'New messages will be forwarded to server ($_serverUrl)'
        : 'New messages will not be forwarded to server';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          title: Text('IcareSMS: Log View'),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              // Navigate to settings and wait for changes to be saved
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SmsSetting()),
              );
              // Reload preferences after returning from settings
              _loadPreferences();
            },
            child: Container(
              color: Colors.grey[600],
              child: Center(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
