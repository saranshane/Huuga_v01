class Recipient {
  final String id;
  final String name;
  final int age;
  final String gender;

  Recipient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
    );
  }
}
