//onboarding Screen Data Model

class OnboardingData {
  final String image;
  final String title;
  final String text;

  OnboardingData({
    required this.image,
    required this.title,
    required this.text,
  });
}

List<OnboardingData> demoData = [
  OnboardingData(
    image: 'assets/images/Onboarding_1.jpeg',
    title: 'Stay Anonymous',
    text: 'Stay anonymous while connecting with friends.',
  ),
  OnboardingData(
    image: 'assets/images/people.jpg',
    title: 'Express Feelings',
    text: 'Express your feelings through anonymous chat.',
  ),
  OnboardingData(
    image: 'assets/images/Onboarding_3.jpeg',
    title: 'Choose a Person',
    text: 'Choose a person to chat anonymously.',
  ),
];
