// class Conversation {
//   final String id;
//   final DateTime createdAt;
//   final bool expired;
//   final DateTime expiresAt;
//   final List<Recipient> recipients;
//   final String text;
//   final DateTime updatedAt;

//   Conversation({
//     required this.id,
//     required this.createdAt,
//     required this.expired,
//     required this.expiresAt,
//     required this.recipients,
//     required this.text,
//     required this.updatedAt,
//   });

//   factory Conversation.fromJson(Map<String, dynamic> json) {
//     return Conversation(
//       id: json['_id'] ?? '',
//       createdAt: DateTime.parse(json['createdAt'] ?? ''),
//       expired: json['expired'] ?? false,
//       expiresAt: DateTime.parse(json['expiresAt'] ?? ''),
//       recipients: (json['recipients'] as List<dynamic>)
//           .map((recipient) => Recipient.fromJson(recipient))
//           .toList(),
//       text: json['text'] ?? '',
//       updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
//     );
//   }
// }

// class Recipient {
//   final String id;
//   final String name;
//   final int age;
//   final String gender;

//   Recipient({
//     required this.id,
//     required this.name,
//     required this.age,
//     required this.gender,
//   });

//   factory Recipient.fromJson(Map<String, dynamic> json) {
//     return Recipient(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       age: json['age'] ?? 0,
//       gender: json['gender'] ?? '',
//     );
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';
import './recepient.dart';

class Conversation {
  final String id;
  final DateTime createdAt;
  final bool expired;
  final DateTime expiresAt;
  final List<Recipient> recipients;
  final String text;
  final DateTime updatedAt;

  // Constructor
  Conversation({
    required this.id,
    required this.createdAt,
    required this.expired,
    required this.expiresAt,
    required this.recipients,
    required this.text,
    required this.updatedAt,
  });
 

  // Factory method to create Conversation object from JSON
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      expired: json['expired'] ?? false,
      expiresAt: DateTime.parse(json['expiresAt'] ?? ''),
      recipients: (json['recipients'] as List<dynamic>)
          .map((recipient) => Recipient.fromJson(recipient))
          .toList(),
      text: json['text'] ?? '',
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
    );
  }

  // Method to save user ID using shared preferences
  Future<void> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  // Method to retrieve user ID using shared preferences
  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

}
