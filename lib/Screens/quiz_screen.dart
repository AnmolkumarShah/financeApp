import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Models/question_model.dart';
import 'package:finance_app/Models/verdict.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late InfiniteScrollController _controller;
  int _selectedIndex = 0;
  double? _itemExtent;
  double get screenWidth => MediaQuery.of(context).size.width;
  @override
  void initState() {
    super.initState();
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 50;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  markAnswered(QuestionModel que) {
    que.markAnswered();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: InfiniteCarousel.builder(
          center: true,
          loop: false,
          itemCount: allQustions.length,
          itemExtent: _itemExtent!,
          controller: _controller,
          onIndexChanged: (index) {
            if (_selectedIndex != index) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          itemBuilder: (context, itemIndex, realIndex) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Question ${itemIndex + 1} of ${allQustions.length}"),
                  ),
                ),
                Container(
                  // width: 300,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: kElevationToShadow[2],
                    color: Colors.blue,
                  ),
                  child: Column(
                    children: [
                      Question(
                        question: allQustions[itemIndex].question,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ...allQustions[itemIndex]
                          .options!
                          .map((e) => Answer(
                                ans: e,
                                isAnswered: allQustions[itemIndex].isAnswered,
                                fun: () => markAnswered(allQustions[itemIndex]),
                              ))
                          .toList(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        allQustions[itemIndex].clearAll();
                        setState(() {});
                      },
                      label: const Text("Clear"),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: () {
                        _controller.nextItem();
                      },
                      label: const Text("Next"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                itemIndex == allQustions.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          List<int> result = [0, 0, 0];
                          for (var item in allQustions) {
                            final ans = item.finalAns();
                            result[ans] += 1;
                          }
                          var temp = [...result];
                          result.sort();

                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 500,
                                padding: const EdgeInsets.all(30),
                                child: Text(
                                  verdict[temp.indexOf(result.last)]!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 27,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text("Show Result"),
                      )
                    : const SizedBox(
                        height: 0,
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}

class Question extends StatelessWidget {
  String? question;
  Question({Key? key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        question!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }
}

class Answer extends StatefulWidget {
  Option? ans;
  Function? fun;
  bool? isAnswered;
  Answer({Key? key, this.ans, this.fun, this.isAnswered}) : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.isAnswered == false) {
            widget.ans!.select(widget.ans!.selected);
            widget.fun!();
            setState(() {});
          } else {
            showSnakeBar(context, "Please clear before selecting other option");
          }
        },
        child: Card(
          color: widget.ans!.selected == true
              ? Colors.redAccent
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.ans!.statement!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
