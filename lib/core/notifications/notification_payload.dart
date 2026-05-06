class NotificationPayload {
  final String type;
  final String id;

  NotificationPayload({
    required this.type,
    required this.id,
  });

  factory NotificationPayload.fromMap(Map<String, dynamic> map) {
    return NotificationPayload(
      type: map['type'] ?? '',
      id: map['id'] ?? '',
    );
  }
}