// class Complaint {
//   final String description;
//   final String category;
//   final String status;
//   final String stdId;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Complaint({
//     required this.description,
//     required this.category,
//     required this.status,
//     required this.stdId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   // Factory constructor to create a Complaint from JSON
//   factory Complaint.fromJson(Map<String, dynamic> json) {
//     return Complaint(
//       description: json['description'],
//       category: json['category'],
//       status: json['status'],
//       stdId: json['stdId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }

//   // Method to convert a Complaint instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'description': description,
//       'category': category,
//       'status': status,
//       'stdId': stdId,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }
class Complaint {
  final String description;
  final String category;
  final String status;
  final String stdId;
  final String name;

  Complaint({
    required this.description,
    required this.category,
    required this.status,
    required this.stdId,
    required this.name,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      status: json['status'] ?? '',
      stdId: json['stdId'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'category': category,
      'status': status,
      'stdId': stdId,
      'name': name,
    };
  }
}
