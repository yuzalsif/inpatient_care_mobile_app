import 'package:flutter/material.dart';

import 'style.dart';
import 'IncomingMsgService.dart';
import 'provider.dart';

class SmsSetting extends StatefulWidget {
  const SmsSetting({super.key});

  @override
  State<SmsSetting> createState() => _SmsSettingState();
}

class _SmsSettingState extends State<SmsSetting> {
  bool _enableIcareSMS = false;
  bool _keepNewMessages = false;
  bool _callNotifications = false;
  bool _forwardSentMessages = false;
  bool _testMode = false;
  bool _networkFailover = false;


  String _selectedInterval = '30 sec'; // Default interval
  String _serveUrl = 'http://192.168.17.49:85/openmrs/ws/rest/v1/icare/envayasms/handle-actions';
  String _phoneNumber = '255689798797';
  String _password = '123';

  void _toggleSwitch(String switchName, bool value) {
    setState(() {
      switch (switchName) {
        case 'enableEnvayaSMS':
          _enableIcareSMS = value;
          break;
        case 'keepNewMessages':
          _keepNewMessages = value;
          break;
        case 'callNotifications':
          _callNotifications = value;
          break;
        case 'forwardSentMessages':
          _forwardSentMessages = value;
          break;
        case 'testMode':
          _testMode = value;
          break;
        case 'networkFailover':
          _networkFailover = value;
          break;
      }
    });
  }

  void _showServerUrlDialog() {
    final TextEditingController serverUrlController = TextEditingController(text: _serveUrl);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Server URL'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serverUrlController,
                decoration: const InputDecoration(
                  labelText: 'Server URL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog without saving
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _serveUrl = serverUrlController.text;
                });
                Navigator.of(context).pop(); // Dismiss the dialog after saving
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _showPhoneNumberDialog() {
    final TextEditingController phoneNumberController = TextEditingController(
      text: _phoneNumber,
    );

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Phone Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _phoneNumber = phoneNumberController.text;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordDisplay() {
    return Text(
      '*' * _password.length,
      style: AppStyles.subtitleStyle(),
    );
  }

  void _showPasswordDialog() {
    final TextEditingController passwordController = TextEditingController(
      text: _password,
    );

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false, // Disable suggestions for better privacy
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _password = passwordController.text;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPollIntervalDialog() {
    final List<String> intervals = ['5 sec', '15 sec', '30 sec', '1 min', '5 min', '10 min', '30 min'];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Poll Interval'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: intervals.map((interval) {
                return ListTile(
                  title: Text(interval),
                  onTap: () {
                    setState(() {
                      _selectedInterval = interval;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45.0),
        child: AppBar(
          title: const Text('IcareSMS: Setting'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          // Enable EnvayaSMS Section
          SwitchListTile(
            title: Text('Enable IcareSMS', style: AppStyles.titleStyle()),
            subtitle: Text(
              'New messages will not be forwarded between phone and server',
              style: AppStyles.subtitleStyle(),
            ),
            value: _enableIcareSMS,
            onChanged: (bool value) {
              setState(() {
                _toggleSwitch('enableEnvayaSMS', value);
              });

              if (value) {
                // Call SMService.fetchSmsData() when the switch is turned on
                SMService.fetchSmsData();
                IncomingMsg().listenForIncomingSms();
              }
            },
          ),

          Divider(color: Colors.grey[800]),
          // Server Settings Section
          Text(
            'Server Settings',
            style: AppStyles.sectionTitleStyle(),
          ),
          ListTile(
            title: Text('Server URL', style: AppStyles.titleStyle()),
            subtitle: Text(
              _serveUrl,
              style: AppStyles.subtitleStyle(),
            ),
            onTap: _showServerUrlDialog,
          ),
          ListTile(
            title: Text('Your phone number', style: AppStyles.titleStyle()),
            subtitle: Text(_phoneNumber,
                style: AppStyles.subtitleStyle()
            ),
            onTap: _showPhoneNumberDialog,
          ),
          ListTile(
            title: Text('Password', style: AppStyles.titleStyle()),
            subtitle: _buildPasswordDisplay(),
            onTap: _showPasswordDialog,
          ),
          ListTile(
            title: Text('Poll interval', style: AppStyles.titleStyle()),
            subtitle: Text(_selectedInterval, style: AppStyles.subtitleStyle()), // Update subtitle with _selectedInterval
            onTap: _showPollIntervalDialog,
          ),
          Divider(color: Colors.grey[800]),

          // Messaging Settings Section
          Text(
            'Messaging Settings',
            style: AppStyles.sectionTitleStyle(),
          ),
          SwitchListTile(
            title: Text('Keep new messages', style: AppStyles.titleStyle()),
            subtitle: Text(
              'Incoming messages will not be stored in Messaging inbox',
              style: AppStyles.subtitleStyle(),
            ),
            value: _keepNewMessages,
            onChanged: (bool value) => _toggleSwitch('keepNewMessages', value),
          ),
          SwitchListTile(
            title: Text('Call notifications', style: AppStyles.titleStyle()),
            subtitle: Text(
              'IcareSMS will notify server when phone receives an incoming call',
              style: AppStyles.subtitleStyle(),
            ),
            value: _callNotifications,
            onChanged: (bool value) => _toggleSwitch('callNotifications', value),
          ),
          ListTile(
            title: Text('SMS rate limit', style: AppStyles.titleStyle()),
            subtitle: Text('Send up to 100 SMS per hour.\nClick to increase limit...',
                style: AppStyles.subtitleStyle()),
          ),
          Divider(color: Colors.grey[800]),

          // Additional Settings from the new image
          SwitchListTile(
            title: Text('Forward sent messages', style: AppStyles.titleStyle()),
            subtitle: Text('SMS sent from Messaging app will not be forwarded to server',
                style: AppStyles.subtitleStyle()),
            value: _forwardSentMessages,
            onChanged: (bool value) => _toggleSwitch('forwardSentMessages', value),
          ),
          ListTile(
            title: Text(
              'Ignored phones',
              style: AppStyles.titleStyle(),
            ),
            subtitle: Text(
              'Configure the phone number '
                  'that IcareSMS will ignore',
              style: AppStyles.subtitleStyle(),
            ),
          ),
          SwitchListTile(
            title: Text('Test Mode', style: AppStyles.titleStyle()),
            subtitle: Text('Enable to test new features before release',
                style: AppStyles.subtitleStyle()),
            value: _testMode,
            onChanged: (bool value) => _toggleSwitch('testMode', value),
          ),
          ListTile(
            title: Text(
              'Sender phones',
              style: AppStyles.titleStyle(),
            ),
            subtitle: Text(
              'Configure the phone number '
                  'that IcareSMS will handle',
              style: AppStyles.subtitleStyle(),
            ),
          ),
          Divider(color: Colors.grey[800]),
          Text(
            'Networking Setting',
            style: AppStyles.sectionTitleStyle(),
          ),
          ListTile(
            title: Text(
              'Wi-Fi sleep policy',
              style: AppStyles.titleStyle(),
            ),
            subtitle: Text(
              'Wi-Fi will stand connects when the phone sleep',
              style: AppStyles.subtitleStyle(),
            ),
          ),
          SwitchListTile(
            title: Text('Network Fail over', style: AppStyles.titleStyle()),
            subtitle: Text('Use network fail over to prevent data loss',
                style: AppStyles.subtitleStyle()),
            value: _networkFailover,
            onChanged: (bool value) => _toggleSwitch('networkFailover', value),
          ),
        ],
      ),
    );
  }
}
