import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyClickableText(),
    );
  }
}

class MyClickableText extends StatefulWidget {
  @override
  State<MyClickableText> createState() => _MyClickableTextState();
}

class _MyClickableTextState extends State<MyClickableText> {
  var phraseText = '';

  var wordText = '';

  void _onPhraseTap(String phrase) {
   setState(() {
     phraseText = phrase;
   });
    print('Clicked on phrase: $phrase');
  }

  void _onWordTap(String word) {
    setState(() {
      wordText = word;
    });
    print('Clicked on word: $word');
  }

  @override
  Widget build(BuildContext context) {
    String text = """
Lorem Ipsum is simply dummy text of the printing and typesetting industry.
 Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
  It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
   It was popularised in the 1960s with the release of Letraset sheets containing
    Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
""";

    List<String> phrases = [
      "simply dummy",
      "typesetting industry",
      "printer took",
      "specimen book",
      "five centuries",
      "including versions",
      "Lorem Ipsum"
    ];

    List<TextSpan> textSpans = [];
    String tempText = text;

    for (String phrase in phrases) {
      while (tempText.contains(phrase)) {
        var splitText = tempText.split(phrase);
        splitText[0].split(RegExp(r'\s+')).forEach((word) {
          if(word.isNotEmpty){
            textSpans.add(
              TextSpan(
                text: '$word ',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _onWordTap(word);
                  },
              ),
            );
          }
        });

        textSpans.add(
          TextSpan(
            text: phrase,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _onPhraseTap(phrase);
              },
          ),
        );

        tempText = splitText.length > 1 ? splitText.sublist(1).join(phrase) : "";
      }
    }

    tempText.split(RegExp(r'\s+')).forEach((word) {
      if(word.isNotEmpty){
        textSpans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _onWordTap(word);
              },
          ),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50 , vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("phrase : $phraseText" , style: TextStyle(fontSize: 18.0, color: Colors.orange),),
              const SizedBox(height: 20,),
              Text("words : $wordText" ,   style: TextStyle(fontSize: 18.0, color: Colors.orange),),
              const SizedBox(height: 20,),
              Center(
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: textSpans, style: const TextStyle(color: Colors.black, fontSize: 18.0 ,
                      height: 1.5
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
