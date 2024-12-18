
import 'package:flutter/material.dart';

import 'sms_setting.dart';


class LogViewScreen extends StatefulWidget {
  const LogViewScreen({super.key});

  @override
  LogViewScreenState createState() => LogViewScreenState();
}

class LogViewScreenState extends State<LogViewScreen> {

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SmsSetting()));
            },
            child: Container(
              color: Colors.grey[600],
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'IcareSMS disabled',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      'New messages will not be forwarded to server',
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
