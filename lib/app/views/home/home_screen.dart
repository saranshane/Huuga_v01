import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/app/widgets/primary_tab.dart';
import 'package:login/app/widgets/requests_tab.dart';
import 'package:login/app/views/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/Hygge_Text_Banner.png',
          height: 30,
          semanticLabel: 'Hygge Banner',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add notifications functionality
            },
            tooltip: 'Notifications',
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.pink[600],
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.pink[600],
              tabs: [
                Tab(text: 'Primary'),
                Tab(text: 'Requests'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PrimaryTab(), // Primary tab content
                  RequestsTab(), // Requests tab content
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
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigate to home screen
              },
              tooltip: 'Home', // Tooltip
            ),
            SizedBox(
                width:
                    48), // The dummy child to space out the icons and leave space for the FAB
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
