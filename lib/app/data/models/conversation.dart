class Conversation {
  final Recipient recipient;
  final String text;
  final DateTime updatedAt;
  final int id;

  Conversation({
    required this.recipient,
    required this.text,
    required this.updatedAt,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'recipient': recipient.toJson(),
      'text': text,
      'updatedAt': updatedAt.toIso8601String(),
      'id': id,
    };
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      recipient: Recipient.fromJson(json['recipient']),
      text: json['text'],
      updatedAt: DateTime.parse(json['updatedAt']),
      id: json['id'],
    );
  }
}

class Recipient {
  final String name;
  final String image;

  Recipient({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      name: json['name'],
      image: json['image'],
    );
  }
}
// class Conversation {
//   final Recipient recipient;
//   final String text;
//   final DateTime updatedAt;
//   final int id;
//   final int unreadCount;

//   Conversation({
//     required this.recipient,
//     required this.text,
//     required this.updatedAt,
//     required this.id,
//     required this.unreadCount,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'recipient': recipient.toJson(),
//       'text': text,
//       'updatedAt': updatedAt.toIso8601String(),
//       'id': id,
//       'unreadCount': unreadCount,
//     };
//   }

//   factory Conversation.fromJson(Map<String, dynamic> json) {
//     return Conversation(
//       recipient: Recipient.fromJson(json['recipient']),
//       text: json['text'],
//       updatedAt: DateTime.parse(json['updatedAt']),
//       id: json['id'],
//       unreadCount: json['unreadCount'],
//     );
//   }
// }

// class Recipient {
//   final String name;
//   final String image;

//   Recipient({
//     required this.name,
//     required this.image,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'image': image,
//     };
//   }

//   factory Recipient.fromJson(Map<String, dynamic> json) {
//     return Recipient(
//       name: json['name'],
//       image: json['image'],
//     );
//   }
// }
