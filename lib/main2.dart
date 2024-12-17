import 'package:flutter/material.dart';

void main() async => runApp(const MyApp());

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final String word = "TRIPLE";
  final double size = 170;
  final double space = 10;

  late final List<Color> colors = Colors.primaries
      .take(word.length)
      .map((MaterialColor m) => m.shade800)
      .toList();
  late final int containerNumber = word.length;
  late final List<Rect> positions = List.generate(
      containerNumber,
          (index) => getRectangle(index, containerNumber, size)
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50,),
                      ElevatedButton(
                          onPressed: shuffle,
                          child: const Text("Shuffle")
                      ),
                      const SizedBox(height: 50,),
                      SizedBox(
                          height: containerNumber ~/3 * (size+space) - space,
                          width: 3 * (size+space) - space,
                          child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: List.generate(containerNumber, (index) {
                              return AnimatedPositioned.fromRect(
                                rect: positions[index],
                                duration: const Duration(milliseconds: 500),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colors[index],
                                  ),
                                  width: size,
                                  height: size,
                                  child: Text(
                                    word[index],
                                    style: const TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                      ),
                    ]
                ),
              )
          )
      ),
    );
  }

  Rect getRectangle(int index, int length, double size) {
    return
      Offset(index % 3 * (size + space), index ~/3 * (size + space))
      & Size.square(size);
  }

  void shuffle() {
    setState(() {
      positions.shuffle();
    });
  }
}