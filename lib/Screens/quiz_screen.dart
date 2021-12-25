import 'dart:math';

import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Models/question_model.dart';
import 'package:finance_app/Models/verdict.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Screens/quiz_given_screen.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:finance_app/Services/text_style.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';

abc(int idx) {
  switch (idx) {
    case 0:
      return 'A';
    case 1:
      return 'B';
    case 2:
      return 'C';
    case 3:
      return 'D';
    default:
      return 'D';
  }
}

class QuizScreen extends StatefulWidget {
  bool isNew = false;
  QuizScreen({Key? key, this.isNew = false}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late InfiniteScrollController _controller;
  int _selectedIndex = 0;
  double? _itemExtent;
  double get screenWidth => MediaQuery.of(context).size.width;
  List<QuestionModel> allQue = allQustions;
  static int count = 0;

  initFunction() async {
    if (count > 0) return;
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    int id = data['id'];
    List<dynamic> result = await Query.execute(
        query: 'select * from fianacial where Profile_id = $id');
    if (result.isNotEmpty && !widget.isNew) {
      showSnakeBar(context, "You Have Attended The Quiz Earlier");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizGivenScreen(
            response: result[0],
          ),
        ),
      );
    }
    count++;
  }

  @override
  void initState() {
    super.initState();
    count = 0;
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
    for (var element in allQue) {
      element.clearAll();
    }
    count = 0;
  }

  markAnswered(QuestionModel que) {
    que.markAnswered();
    setState(() {});
  }

  bool loading = false;
  List<int> result = [0, 0, 0];

  Future<bool> save(List<QuestionModel> list) async {
    setState(() {
      loading = true;
    });
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    int id = data['id'];
    try {
      List<dynamic> pre = await Query.execute(
          query: 'select * from fianacial where Profile_id = $id');
      dynamic result;
      if (pre.isEmpty) {
        result = await Query.execute(p1: '1', query: '''
    insert into fianacial(profile_id,answer,answer1,answer2,answer3,answer4,answer5,
    answer6,answer7,answer8,answer9)
    values($id,${list[0].finalAns()},${list[1].finalAns()},${list[2].finalAns()},
    ${list[3].finalAns()},${list[4].finalAns()},${list[5].finalAns()},${list[6].finalAns()},
    ${list[7].finalAns()},${list[8].finalAns()},${list[9].finalAns()})
    ''');
      } else {
        result = await Query.execute(p1: '1', query: '''
        update fianacial
        set Answer = ${list[0].finalAns()},Answer1 = ${list[1].finalAns()},
        Answer2 = ${list[2].finalAns()},Answer3 = ${list[3].finalAns()},
        Answer4 = ${list[4].finalAns()},Answer5 = ${list[5].finalAns()},
        Answer6 = ${list[6].finalAns()},Answer7 = ${list[7].finalAns()},
        Answer8 = ${list[8].finalAns()},Answer9 = ${list[9].finalAns()}
        where profile_id = $id
        ''');
      }
      print(result);
      setState(() {
        loading = false;
      });
      if (result['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (count > 0 && !widget.isNew) return Future(() async {});
      showSnakeBar(context, "You Can Swipe Right To Move To Next Question");
    });
    return Scaffold(
      body: FutureBuilder(
          future: initFunction(),
          builder: (context, snapshot) {
            return SafeArea(
              child: InfiniteCarousel.builder(
                center: true,
                loop: false,
                itemCount: allQue.length,
                itemExtent: _itemExtent!,
                controller: _controller,
                onIndexChanged: (index) {
                  if (_selectedIndex != index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }
                  if (!allQue[_selectedIndex - 1].isAnswered) {
                    showSnakeBar(context, "Select Option Before proceeding");
                    _controller.previousItem();
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
                            "Question ${itemIndex + 1} of ${allQue.length}",
                            style: MyTextStyle.simple,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
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
                              question: allQue[itemIndex].question,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ...allQue[itemIndex]
                                .options!
                                .map((e) => Answer(
                                      ans: e,
                                      isAnswered: allQue[itemIndex].isAnswered,
                                      fun: () =>
                                          markAnswered(allQue[itemIndex]),
                                      op: abc(allQue[itemIndex]
                                          .options!
                                          .indexOf(e)),
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
                              allQue[itemIndex].clearAll();
                              setState(() {});
                            },
                            label: const Text("Clear"),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.navigate_next),
                            onPressed: () {
                              if (allQue[itemIndex].isAnswered) {
                                _controller.nextItem();
                              } else {
                                showSnakeBar(
                                    context, "Select Option Before proceeding");
                              }
                            },
                            label: const Text("Next"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      itemIndex == allQue.length - 1
                          ? loading == true
                              ? Loader.circular
                              : ElevatedButton(
                                  onPressed: () async {
                                    for (var item in allQue) {
                                      final ans = item.finalAns();
                                      result[ans] += 1;
                                    }
                                    int temp = result.reduce(max);
                                    bool res = await save(allQue);
                                    if (res == true) {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 500,
                                            padding: const EdgeInsets.all(30),
                                            child: Column(
                                              children: [
                                                Text(
                                                  verdict[
                                                      result.indexOf(temp)]!,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 27,
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        content: ListTile(
                                                          title: const Text(
                                                              "Your Selected Answer Count"),
                                                          subtitle: Text(
                                                            "Option A : ${result[0]}\nOption B : ${result[1]}\nOption C : ${result[2]}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.info_outline),
                                                  label: const Text("More"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      showSnakeBar(
                                          context, "Error In Saving Answers");
                                    }
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
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.cancel),
            Text("Close Quiz"),
          ],
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
    return Text(
      question!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    );
  }
}

class Answer extends StatefulWidget {
  String? op;
  Option? ans;
  Function? fun;
  bool? isAnswered;
  Answer({
    Key? key,
    this.ans,
    this.fun,
    this.isAnswered,
    this.op,
  }) : super(key: key);

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
        child: Row(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(widget.op!),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.ans!.selected == true
                      ? Colors.redAccent
                      : Colors.black54,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ans!.statement!,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
