import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/app/data/models/conversation.dart'; // Adjust import path as necessary

class ConversationController extends GetxController {
  RxList<Conversation> conversations = <Conversation>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  void loadConversations() async {
    final prefs = await SharedPreferences.getInstance();
    String? conversationsString = prefs.getString('conversations');

    if (conversationsString != null) {
      List<dynamic> conversationsJson = jsonDecode(conversationsString);
      conversations.value = conversationsJson.map((json) => Conversation.fromJson(json)).toList();
    }
  }

  void addConversation(Conversation conversation) async {
    conversations.add(conversation);
    await saveConversations();
  }

  Future<void> saveConversations() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> conversationsJson = conversations.map((c) => c.toJson()).toList();
    prefs.setString('conversations', jsonEncode(conversationsJson));
  }
}


