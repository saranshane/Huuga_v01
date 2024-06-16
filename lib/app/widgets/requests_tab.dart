import 'package:flutter/material.dart';
import 'package:login/models/friends_list.dart';

class RequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                elevation: 0, // This will remove the shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF9431A5), // Left side color
                                      Color(0xFFAC303B), // Right side color
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Text(
                                    'Accept & Talk',
                                    style: TextStyle(color: Colors.white),
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
    );
  }
}
