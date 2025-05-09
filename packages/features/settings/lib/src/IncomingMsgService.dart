import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'log_service.dart';

class IncomingMsg {
  final Telephony telephony = Telephony.instance;
  bool smsEnabled = false; // Track SMS listening status
  static String serverUrl = "http://192.168.1.147:8081/sms/receive"; // Default server URL

  static void updateServerUrl(String newUrl) {
    if (serverUrl != newUrl) {
      serverUrl = newUrl;
      LogService.addLog("Server URL update to: ($serverUrl)");
    }

  }

  static Future<bool> _requestSmsPermission() async {
    var smsStatus = await Permission.sms.status;
    if (!smsStatus.isGranted) {
      smsStatus = await Permission.sms.request();
    }
    return smsStatus.isGranted;
  }

  void toggleSmsListening(bool enable) async {
    if (enable && !smsEnabled) {
      smsEnabled = true;
      _log("Listening for incoming SMS...");
      //await listenForIncomingSms();
    } else if (!enable && smsEnabled) {
      smsEnabled = false;
      _log("SMS listening disabled.");
    }
  }

  static Future<void> listenIncomingSms(Function(String) onSuccess) async {
    bool permissionGranted = await _requestSmsPermission();

    if (permissionGranted) {
      final Telephony telephony = Telephony.instance;
      telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          _log("SMS received: ${message.body}");
          onSuccess("SMS received from ${message.address}: ${message.body}");
        },
        onBackgroundMessage: backgroundMessageHandler,
        listenInBackground: true,
      );
    } else {
      _log("SMS permission not granted");
    }
  }

  void listenForIncomingSms() async {
    // if (smsEnabled) {
    //   _log("Already listening for incoming SMS.");
    //   return;
    // }

    bool isGranted = await _requestSmsPermission();
    if (isGranted) {
      smsEnabled = true;
      //_log("Listening for incoming SMS...");
      telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) async {
          String from = message.address ?? "Unknown";
          String content = message.body ?? "";
          String messageType = message.type.toString();

          try {
           // _log("Processing SMS from $from...");
            await sendIncomingSmsToServer(from, content, messageType);
          } catch (e) {
            _log("Error sending SMS to server: $e");
          }
        },
        onBackgroundMessage: backgroundMessageHandler,
        listenInBackground: true,
      );
    } else {
     // _log("SMS permission not granted.");
    }
  }

  // Background SMS handler
  static Future<void> backgroundMessageHandler(SmsMessage message) async {
    String from = message.address ?? "Unknown";
    String content = message.body ?? "";
    String messageType = message.type.toString();

    try {
     // _log("Background: Processing SMS from $from...");
      await sendIncomingSmsToServer(from, content, messageType);
    } catch (e) {
     // _log("Error sending SMS to server in background: $e");
    }
  }

  // Send SMS to server
  static Future<void> sendIncomingSmsToServer(String from, String content, String messageType) async {
    var url = Uri.parse(serverUrl);

    int retryCount = 0;
    while (retryCount < 3) {
      try {
        var response = await http.post(
          url,
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {
            "action": "incoming",
            "from": from,
            "message": content,
            "messageType": messageType,
          },
        );

        if (response.statusCode == 200) {
         // _log("Incoming SMS sent to server successfully");
          return;
        } else {
          retryCount++;
         // _log("Failed to send SMS to server (Attempt $retryCount): ${response.statusCode}");
          await Future.delayed(Duration(seconds: retryCount * 5));
        }
      } catch (e) {
        retryCount++;
       // _log("Error while contacting server (Attempt $retryCount): $e");
        if (retryCount < 3) {
         // _log("Retrying in ${retryCount * 5} seconds...");
          await Future.delayed(Duration(seconds: retryCount * 5));
        } else {
         // _log("Max retry attempts reached. Aborting.");
        }
      }
    }
  }

  // Helper method for logging
  // Helper method for logging
  static void _log(String message) {
    String timestamp = DateFormat('HH:mm:ss').format(DateTime.now());
    String logMessage = "[$timestamp] $message";
    LogService.addLog(logMessage); // Add log to LogService
  }

}
