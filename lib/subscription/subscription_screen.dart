import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String selectedPlan = '';

  void updateSelectedPlan(String plan) {
    setState(() {
      selectedPlan = plan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('SUBSCRIPTION'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Text('Free', textAlign: TextAlign.center),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Premium',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.star, color: Colors.yellow),
                        Text('2X'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/subs_banner.jpeg', height: 100),
                  SizedBox(height: 8),
                  Text(
                    'Premium',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Better life, better features',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Plans life-time',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildPlanCard('1 Month', '₹49/-', 'Save 60%'),
                buildPlanCard('6 Months', '₹129/month', 'Save 40%'),
                buildPlanCard(
                    '12 Month', '₹500/month', 'Save 20%', 'Most Popular'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'This is a recurring subscription that you can cancel anytime.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: selectedPlan.isNotEmpty
                    ? () {
                        // Add your navigation or action here
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF9431A5),
                        Color(0xFFAC303B),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                    alignment: Alignment.center,
                    child: Text(
                      selectedPlan.isNotEmpty ? selectedPlan : 'Select a plan',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlanCard(String duration, String price, String discount,
      [String? badge]) {
    bool isSelected = selectedPlan == duration;

    return Flexible(
      child: GestureDetector(
        onTap: () {
          updateSelectedPlan(duration);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF9431A5), Color(0xFFAC303B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: isSelected
                        ? Border.all(color: Colors.yellow, width: 3)
                        : null,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (badge != null) SizedBox(height: 16),
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(duration,
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(price,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(discount,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ),
              if (badge != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(badge,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
