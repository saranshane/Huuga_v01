//Primarytab Conversation cards Model
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
}

class Recipient {
  final String name;
  final String image;

  Recipient({required this.name, required this.image});
}

