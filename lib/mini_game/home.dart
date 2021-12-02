import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_game/mini_game/model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<ItemModel> item;
  late List<ItemModel> item2;

  int score = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Mini Game'),
        backgroundColor: const Color(0xffffd740),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isGameOver)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: item.map((items) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: Draggable<ItemModel>(
                              data: items,
                              feedback: Icon(
                                items.icon,
                                color: const Color(0xffffd740),
                                size: 50,
                              ),
                              child: Icon(
                                items.icon,
                                color: Colors.teal,
                                size: 50,
                              ),
                              childWhenDragging: Icon(
                                items.icon,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: item2.map((items) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: DragTarget<ItemModel>(
                              onAccept: (receiveItem) {
                                if (items.value == receiveItem.value) {
                                  setState(() {
                                    item.remove(receiveItem);
                                    item2.remove(items);
                                    score += 10;
                                    items.accepting = false;
                                  });
                                }
                              },
                              onLeave: (receiveItem) {
                                setState(() {
                                  items.accepting = false;
                                });
                              },
                              onWillAccept: (receiveItem) {
                                setState(() {
                                  items.accepting = true;
                                });
                                return true;
                              },
                              builder: (BuildContext context,
                                  List<Object?> acceptedItem,
                                  List<dynamic> rejectedItem) {
                                return Container(
                                  height: 50,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: items.accepting
                                        ? Colors.red
                                        : const Color(0xffffd740),
                                  ),
                                  child: Center(
                                    child: Text(
                                      items.item,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                if (score == 40)
                  AlertDialog(
                    content: SizedBox(
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ...List.generate(
                                    3,
                                    (c) => const Icon(
                                      Icons.star,
                                      size: 40,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Congratulations",
                              style: TextStyle(fontSize: 28),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isGameOver
                                ? ElevatedButton(
                                    onPressed: () {
                                      initGame();
                                    },
                                    child: const Text('Game Over'),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        initGame();
                                      });
                                    },
                                    child: const Text('Try Again'),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    title: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          const TextSpan(
                            text: 'Score :',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: '$score',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xfff57f00),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initGame() {
    score = 0;
    isGameOver = false;

    item = [
      ItemModel(
          accepting: false,
          item: 'Dog',
          value: 'Dog',
          icon: FontAwesomeIcons.dog),
      ItemModel(
          accepting: false,
          item: 'Car',
          value: 'Car',
          icon: FontAwesomeIcons.car),
      ItemModel(
          accepting: false,
          item: 'Cat',
          value: 'Cat',
          icon: FontAwesomeIcons.cat),
      ItemModel(
          accepting: false,
          item: 'Bus',
          value: 'Bus',
          icon: FontAwesomeIcons.bus),
    ];
    item2 = List<ItemModel>.from(item);
    item.shuffle();
    item2.shuffle();
  }
}
