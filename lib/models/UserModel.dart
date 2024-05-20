import 'package:shared_preferences/shared_preferences.dart';

class User {
  String? userId, nickname, gender; // Making userId nullable

  User(this.userId, this.nickname, this.gender);

  // Constructor that converts JSON to object instance
  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        nickname = json['nickname'],
        gender = json['gender'];

  // A method that converts object to JSON map
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nickname': nickname,
        'gender': gender,
      };

  // Method to save user data to SharedPreferences
  Future<void> saveToLocal() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
          'userId', userId ?? ''); // Using null-aware operator to handle null
      prefs.setString('nickname', nickname ?? '');
      prefs.setString('gender', gender ?? '');
    } catch (error) {
      print('Error saving user data locally: $error');
      // Handle error gracefully
    }
  }

  // Method to retrieve user data from SharedPreferences
  static Future<User?> fromLocal() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('userId');
      final String? nickname = prefs.getString('nickname');
      final String? gender = prefs.getString('gender');
      return User(userId, nickname, gender);
    } catch (error) {
      print('Error retrieving user data locally: $error');
      return null; // Return null or handle error case accordingly
    }
  }
}
