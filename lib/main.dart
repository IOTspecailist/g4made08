import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AnimationState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Provider.of<AnimationState>(context, listen: false).fadeIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow.shade100,
        child: Center(
          child: Consumer<AnimationState>(
            builder: (context, animationState, child) {
              return AnimatedOpacity(
                  opacity: animationState.opacity,
                  duration: const Duration(milliseconds: 500),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NextScreen()),
                      );
                    },
                    minWidth: 300,
                    height: 300,
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: const CircleBorder(),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "RUN!",
                        style: TextStyle(fontSize: 150),
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("회원가입")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: "이름"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "이메일"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "비밀번호"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text("회원가입"),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Image.asset('assets/my_image.jpg'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("이미지 보기"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("뒤로 가기"),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationState with ChangeNotifier {
  double _opacity = 0;

  double get opacity => _opacity;

  void fadeIn() {
    _opacity = 1;
    notifyListeners();
  }
}
