import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyClickableText(),
    );
  }
}

class MyClickableText extends StatelessWidget {
  void _onWordTap(String word) {
    print('Clicked on: $word');
  }

  @override
  Widget build(BuildContext context) {
    String text = """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum        
""";

    List<String> words = text.split(RegExp('\\s+'));
    return Scaffold(
      body: Center(
        child: RichText(textAlign: TextAlign.center,
          text: TextSpan(
            children: words.map((word) {
              return TextSpan(
                text: '$word ',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _onWordTap(word);
                  },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
