import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'dart:io';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int correctScore = 0;
  int incorrectScore = 0;
  double score = 0.0;
  int trackingProgress = 0;
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      trackingProgress = quizBrain.currentProgress().round();
      print(trackingProgress);
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      if (quizBrain.isFinished() == true) {
        score = correctScore/(correctScore+incorrectScore)*100;
        Alert(
          context: context,
          type: AlertType.success,
          title: "CONGRATULATION",
          desc: "You've finished the Quizzler Game\n with $score%.\n"
              "Your correct answers are $correctScore\n"
              "Your incorrect answers are $incorrectScore",
          buttons: [
            DialogButton(
              child: Text(
                "RESET",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                quizBrain.reset();
                trackingProgress = 0;
                score = 0;
                incorrectScore = 0;
                setState(() {
                  scoreKeeper.clear();
                });
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
            DialogButton(
              child: Text(
                "QUIT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                exit(0);
                Navigator.pop(context);
                },
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
            )
          ],
        ).show();
      }
      else {
        quizBrain.displayProgressBar();
        //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        //HINT! Step 4 Part B is in the quiz_brain.dart
        //TODO: Step 4 Part C - reset the questionNumber,
        //TODO: Step 4 Part D - empty out the scoreKeeper.

        //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
        if (userPickedAnswer == correctAnswer) {
          correctScore++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          Alert(
            context: context,
            type: AlertType.info,
            title: "QUIZZLER ALERT",
            desc: "Youre answer is correct.\n Your score is $score.",
            buttons: [
              DialogButton(
                child: Text(
                  "Next question",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 160,
              )
            ],
          ).show();
        } else {
          incorrectScore++;
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          Alert(
            context: context,
            type: AlertType.error,
            title: "QUIZZLER ALERT",
            desc: "Youre answer is incorrect.\n Your score is $score.",
            buttons: [
              DialogButton(
                child: Text(
                  "Next question",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 160,
              )
            ],
          ).show();
        }
        quizBrain.nextQuestion();

      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
        FAProgressBar(
          currentValue: trackingProgress,
          displayText: '%',
          progressColor: Colors.indigo,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
