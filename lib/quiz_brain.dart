import 'question.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class QuizBrain {
  int _questionNumber = 0;
  double _trackingProgress = 0;
  //int _score = 0;

  List<Question> _questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
    Question('As far as has ever been reported, no-one has ever seen an ostrich bury its head in the sand.',true),
    Question('Approximately one quarter of human bones are in the feet.',true),
    Question('opeye’s nephews were called Peepeye, Poopeye, Pipeye and Pupeye.',true),
    Question('In ancient Rome, a special room called a vomitorium was available for diners to purge food in during meals.',false),
    Question('The average person will shed 10 pounds of skin during their lifetime.',false),
    Question('Sneezes regularly exceed 100 m.p.h.',true),
    Question('The Great Wall Of China is visible from the moon.',false),
    Question('Virtually all Las Vegas gambling casinos ensure that they have no clocks.',true),
    Question('The total surface area of two human lungs have a surface area of approximately 70 square metres.',true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  //TODO: Step 3 Part A - Create a method called isFinished() here that checks to see if we have reached the last question. It should return (have an output) true if we've reached the last question and it should return false if we're not there yet.
  bool isFinished() {
    if (_questionNumber == _questionBank.length - 1) return true;
    else return false;
  }

  //TODO: Step 3 Part B - Use a print statement to check that isFinished is returning true when you are indeed at the end of the quiz and when a restart should happen.

  //TODO: Step 4 Part A - Create a reset() method here that sets the questionNumber back to 0.
  void reset() {
    _questionNumber = 0;
  }

 double currentProgress() {
   _trackingProgress = (_questionNumber + 1)/_questionBank.length*100.round();
   return _trackingProgress;
 }

  void displayProgressBar() {
    FAProgressBar(
      currentValue: _trackingProgress.round(),
      displayText: '%',
    );
  }
}
