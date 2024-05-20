import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Profile/profile_screen.dart';
import 'package:login/Home/inbox_body.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login/Models/friends_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/Hygge_Text_Banner.png',
          height: 30,
          semanticLabel: 'Hygge Banner', // Semantic label for accessibility
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add notifications functionality
            },
            tooltip: 'Notifications', // Tooltip for accessibility
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: Color(0xFF9431A5),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF9431A5),
              tabs: [
                Tab(text: 'Primary'),
                Tab(text: 'Requests'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Body(), // Primary tab content
                  ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final item = dataList[index];
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${item['time']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'assets/images/avatar.png'), // Replace 'assets/avatar.png' with your image path
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ${item['name']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Feeling: ${item['feeling']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Talk About: ${item['talkAbout']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Handle accept and talk action
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shadowColor: Colors
                                                  .transparent, // This will make the button background transparent
                                              elevation:
                                                  0, // This will remove the shadow
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                            ),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(
                                                        0xFF9431A5), // Left side color
                                                    Color(
                                                        0xFFAC303B), // Right side color
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.topRight,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(13.0),
                                                child: Text(
                                                  'Accept & Talk',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Handle cancel action
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[600],
        onPressed: () {
          // Add floating action button functionality
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Icon(Icons.add),
        tooltip: 'Add', // Tooltip for accessibility
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigate to home screen
              },
              tooltip: 'Home', // Tooltip for accessibility
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Get.to(ProfileScreen());
              },
              tooltip: 'Profile', // Tooltip for accessibility
            ),
          ],
        ),
      ),
    );
  }
}
