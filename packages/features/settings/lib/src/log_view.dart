import 'dart:async';

import 'package:flutter/material.dart';
import 'package:settings/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'IncomingMsgService.dart';
import 'log_service.dart';
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
  String _selectedInterval = '30 sec';
  late Timer _pollingTimer;

  @override
  void initState() {
    super.initState();
    LogService.addListener(_refreshLogs);
    _loadPreferences();
  }

  @override
  void dispose() {
    LogService.removeListener(_refreshLogs);
    _pollingTimer.cancel();
    super.dispose();
  }

  void _refreshLogs() {
    setState(() {}); // Refresh UI when logs are updated
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _enableIcareSMS = prefs.getBool('enableIcareSMS') ?? false;
      _phoneNumber = prefs.getString('phoneNumber') ?? '';
      _serverUrl = prefs.getString('serveUrl') ?? '';
      _selectedInterval = prefs.getString('pollInterval') ?? '30 sec';
    });

    LogService.isEnabled = _enableIcareSMS;

    if (_enableIcareSMS) {
      if (_serverUrl.isNotEmpty && _phoneNumber.isNotEmpty) {
        IncomingMsg.updateServerUrl(_serverUrl);
        SMService.fetchSmsData(_serverUrl);
        IncomingMsg().listenForIncomingSms();
        LogService.addLog("[${_getCurrentTime()}] IcareSMS started.");
        _startPolling(_getIntervalDuration(_selectedInterval));
      } else {
        LogService.addLog("[${_getCurrentTime()}] Error: Missing server URL or phone number.");
      }
    }
  }

  void _startPolling(Duration interval) {
    _pollingTimer.cancel();
    _pollingTimer = Timer.periodic(interval, (_) {
      if (_enableIcareSMS) {
        LogService.addLog("[${_getCurrentTime()}] Checking for messages");
        // Add your message-fetching logic here
      }
    });
  }

  Duration _getIntervalDuration(String interval) {
    switch (interval) {
      case '5 sec':
        return const Duration(seconds: 5);
      case '15 sec':
        return const Duration(seconds: 15);
      case '1 min':
        return const Duration(minutes: 1);
      case '5 min':
        return const Duration(minutes: 5);
      case '10 min':
        return const Duration(minutes: 10);
      case '30 min':
        return const Duration(minutes: 30);
      default:
        return const Duration(seconds: 30); // Default to 30 seconds
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    String title = _enableIcareSMS && _phoneNumber.isNotEmpty
        ? 'IcareSMS running ($_phoneNumber)'
        : 'IcareSMS disabled';
    String subtitle = _enableIcareSMS && _phoneNumber.isNotEmpty
        ? 'New messages will be forwarded to server'
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
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SmsSetting()),
              );
              _loadPreferences();
            },
            child: Container(
              color: Colors.grey[600],
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: LogService.getLogs().length,
                itemBuilder: (context, index) {
                  final log = LogService.getLogs()[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        log,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
