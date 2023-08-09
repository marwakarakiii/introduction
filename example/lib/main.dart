import 'package:flutter/material.dart';
import 'package:introduction/introduction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Introduction Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    showIntroduction();
  }

  Future<void> showIntroduction() async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    showIntroductionCarousel(
      context: context,
      texts: texts,
      itemCount: 4,
      activeDotColor: active,
      inactiveDotColor: inactive,
      images: images,
      confirmMessage: 'Confirm',
      isNetworkImage: false,
    );
  }

  final inactive = const Color.fromRGBO(149, 0, 45, 1);
  final active = const Color.fromRGBO(33, 104, 121, 1);
  final images = [
    'lib/assets/images/buy.png',
    'lib/assets/images/chat.png',
    'lib/assets/images/book.png',
    'lib/assets/images/image.png',
    'lib/assets/images/image.png',
  ];
  final texts = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'Nam hendrerit nisi sed sollicitudin pellentesque',
    'Nunc posuere purus rhoncus pulvinar aliquam',
    'Ut aliquet tristique nisl vitae volutpat',
    'Nulla aliquet porttitor venenatis'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Introduction Demo'),
          ],
        ),
      ),
    );
  }
}