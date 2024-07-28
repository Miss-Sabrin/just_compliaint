class Responder {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;

  Responder({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  factory Responder.fromJson(Map<String, dynamic> json) {
    return Responder(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}

class Response {
  final String id;
  final String inboxId;
  final Responder responder;
  final String text;
  final DateTime respondedAt;

  Response({
    required this.id,
    required this.inboxId,
    required this.responder,
    required this.text,
    required this.respondedAt,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['_id'],
      inboxId: json['inboxId'],
      responder: Responder.fromJson(json['responderId']),
      text: json['text'],
      respondedAt: DateTime.parse(json['respondedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'inboxId': inboxId,
      'responderId': responder.toJson(),
      'text': text,
      'respondedAt': respondedAt.toIso8601String(),
    };
  }
}
