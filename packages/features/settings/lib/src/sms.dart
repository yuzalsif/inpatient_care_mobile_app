class Event {
  final String event;
  final List<Message> messages;

  Event({required this.event, required this.messages});

  factory Event.fromJson(Map<String, dynamic> json) {
    var messagesFromJson = json['messages'] as List;
    List<Message> messageList =
    messagesFromJson.map((message) => Message.fromJson(message)).toList();

    return Event(
      event: json['event'],
      messages: messageList,
    );
  }
}

class Message {
  final String id;
  final String to;
  final String message;

  Message({required this.id, required this.to, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      to: json['to'],
      message: json['message'],
    );
  }
}

class SmsResponse {
  final List<Event> events;

  SmsResponse({required this.events});

  factory SmsResponse.fromJson(Map<String, dynamic> json) {
    var eventsFromJson = json['events'] as List;
    List<Event> eventList =
    eventsFromJson.map((event) => Event.fromJson(event)).toList();
    return SmsResponse(events: eventList);
  }
}