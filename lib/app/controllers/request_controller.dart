import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/app/data/models/conversation.dart';
import 'package:login/app/controllers/conversation_controller.dart';

class RequestsController extends GetxController {
  var requests = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  late String userId;
  final ConversationController conversationController =
      Get.put(ConversationController());

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
      final prefs = await SharedPreferences.getInstance();
      final acceptedRequests = prefs.getStringList('acceptedRequests') ?? [];

      final response = await http.get(
          Uri.parse('http://172.20.10.5:3000/api/requests/notmadeby/$userId'));

      if (response.statusCode == 200) {
        final List<dynamic> requestData = jsonDecode(response.body)['requests'];

        for (var request in requestData) {
          if (!acceptedRequests.contains(request['_id'])) {
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
          .get(Uri.parse('http://172.20.10.5:3000/api/user/$senderId'));

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
        Uri.parse('http://172.20.10.5:3000/api/acceptrequest'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'requestId': requestId,
          'recipientId': userId,
        }),
      );

      if (response.statusCode == 200) {
        print('Request accepted successfully');
        final request =
            requests.firstWhere((request) => request['requestId'] == requestId);
        conversationController.addConversation(Conversation(
          recipient: Recipient(
            name: request['name'],
            image: 'assets/images/avatar3.png', // Adjust as necessary
          ),
          text: request['talkAbout'],
          updatedAt: DateTime.now(),
          id: requestId.hashCode, // Adjust as necessary
        ));

        // Persist the accepted request ID
        List<String> acceptedRequests =
            prefs.getStringList('acceptedRequests') ?? [];
        acceptedRequests.add(requestId);
        await prefs.setStringList('acceptedRequests', acceptedRequests);

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
