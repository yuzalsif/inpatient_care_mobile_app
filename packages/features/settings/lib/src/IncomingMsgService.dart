import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;

class IncomingMsg {

  final Telephony telephony = Telephony.instance;

  // Request SMS permission
  static Future<bool> _requestSmsPermission() async {
    var smsStatus = await Permission.sms.status;
     print(smsStatus);
    // If permission isn't granted, request it
    if (!smsStatus.isGranted) {
      smsStatus = await Permission.sms.request();
    }

    // Return true if permission is granted
    return smsStatus.isGranted;
  }

  // Function to listen for incoming SMS
  static Future<void> listenIncomingSms(Function(String) onSuccess) async {
    // Ensure permission is granted before listening to SMS
    bool permissionGranted = await _requestSmsPermission();
     print(permissionGranted);
    if (permissionGranted) {
      final Telephony telephony = Telephony.instance;

      // Start listening for incoming SMS
      telephony.listenIncomingSms(onNewMessage: (SmsMessage message) {
        print("SMS received: ${message.body}");
        onSuccess("SMS received from ${message.address}: ${message.body}");
      });
    } else {
      print("SMS permission not granted");
    }
  }

  // Listen for incoming SMS and send the data to the server
  void listenForIncomingSms() async {
    bool isGranted = await _requestSmsPermission();
    if (isGranted) {
      print("Listening for incoming SMS...");
      telephony.listenIncomingSms(onNewMessage: (SmsMessage message) async {
        print("Received SMS from ${message.address}, content: ${message.body}");
        String from = message.address ?? "Unknown";
        String content = message.body ?? "";
        String messageType = message.type.toString();  // 1 for incoming SMS

        try {
          await sendIncomingSmsToServer(from, content, messageType);
        } catch (e) {
          print("Error sending SMS to server: $e");
        }
      });
    } else {
      print("SMS permission not granted.");
    }
  }

  // Send incoming SMS data to the server
  static Future<void> sendIncomingSmsToServer(String from, String content, String messageType) async {
    var url = Uri.parse('http://192.168.1.147:8081/sms/receive');
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
        print("Incoming SMS sent to server successfully");
      } else {
        print("Failed to send incoming SMS to server: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending SMS to server: $e");
    }
  }
}
