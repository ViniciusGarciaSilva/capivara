import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  double posX = 0;
  late final AnimationController _controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  void _walk() {
    animation ??= Tween(begin: 0.0, end: MediaQuery.of(context).size.width).animate(_controller);
    if (_controller.isAnimating) {
      return;
    } else {
      _controller.repeat();
    }
  }

  void _stop() {
    _controller.stop();
  }

  void _reset() {
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _walk,
                child: const Text(
                  'Andar',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: _stop,
                child: const Text(
                  'Parar',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: _reset,
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: AnimatedBuilder(
            animation: _controller,
            builder: ((context, child) {
              return Transform.translate(
                offset: Offset(animation?.value ?? 0, 0),
                child: Image.asset(
                  'assets/capivara.png',
                  width: 200,
                  height: 200,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
