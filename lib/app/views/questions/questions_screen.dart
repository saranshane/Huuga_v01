import 'package:flutter/material.dart';

final List<String> questions = [
  'What is your favorite color?',
  'Which animal do you like the most?',
  'What is your dream travel destination?',
];

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final List<List<String>> _options = [
    ['Red', 'Blue', 'Green'],
    ['Dog', 'Cat', 'Bird'],
    ['Paris', 'Tokyo', 'New York'],
  ];

  int _currentQuestionIndex = 0;
  List<String> _selectedOptions = ['', '', ''];

  void _handleOptionSelected(String? value) {
    setState(() {
      _selectedOptions[_currentQuestionIndex] = value ?? '';
    });
  }

  void _handleBackward() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    } else {
      // Handle if already at the first question
    }
  }

  void _handleForward() {
    if (_currentQuestionIndex < _options.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      bool allQuestionsAnswered =
          _selectedOptions.every((option) => option.isNotEmpty);
      if (allQuestionsAnswered) {
        // All questions answered, navigate to final screen or perform final action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinalScreen()),
        );
      } else {
        // Show warning message indicating that all questions need to be answered
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Warning'),
              content:
                  Text('Please answer all three questions before proceeding.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _handleBackward,
        ),
        title: Text(
          'Questions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Handle close button press
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _options.length,
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/images/QS_banner.jpeg',
            height: 200,
            width: double.infinity,
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 300, // Adjust this height as needed
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      questions[_currentQuestionIndex],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: _options[_currentQuestionIndex]
                          .map((option) => RadioListTile(
                                title: Text(option),
                                value: option,
                                groupValue:
                                    _selectedOptions[_currentQuestionIndex],
                                onChanged: (value) {
                                  _handleOptionSelected(value);
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _handleBackward,
                icon: Icon(Icons.arrow_back_ios),
              ),
              InkWell(
                onTap: _handleForward,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF9431A5),
                        Color(0xFFAC303B),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    _currentQuestionIndex < _options.length - 1
                        ? Icons.arrow_forward_ios
                        : Icons.done,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Screen'),
      ),
      body: Center(
        child: Text('Congratulations! You have completed the questions.'),
      ),
    );
  }
}
