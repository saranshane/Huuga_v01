import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RequestsController extends GetxController {
  var requests = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  late String userId;

  @override
  void onInit() {
    super.onInit();
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    if (userId.isNotEmpty) {
      fetchRequests();
    } else {
      isLoading(false);
      print('User ID not found in SharedPreferences.');
    }
  }

  Future<void> fetchRequests() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.57.156:3000/api/requests/notmadeby/$userId'));

      if (response.statusCode == 200) {
        final List<dynamic> requestData = jsonDecode(response.body)['requests'];

        for (var request in requestData) {
          final senderId = request['sender'];
          final senderDetails = await fetchUserDetails(senderId);

          if (senderDetails != null) {
            request['senderName'] = senderDetails['name'];
          }

          requests.add({
            'requestId': request['_id'],
            'name': request['senderName'] ?? 'Unknown',
            'feeling': request['feeling'] ?? '',
            'talkAbout': request['message'] ?? '',
            'time': request['time'] ?? '',
          });
        }
      } else {
        print(
            'Failed to load requests: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching requests: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String senderId) async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.57.156:3000/api/user/$senderId'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['user'];
      } else {
        print(
            'Failed to load user details for senderId: $senderId - ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  Future<void> acceptRequest(String requestId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      print('User ID not found in SharedPreferences.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.57.156:3000/api/acceptrequest'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'requestId': requestId,
          'recipientId': userId,
        }),
      );

      if (response.statusCode == 200) {
        print('Request accepted successfully');
        requests.removeWhere((request) => request['requestId'] == requestId);
      } else {
        print(
            'Failed to accept request: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error accepting request: $e');
    }
  }
}
