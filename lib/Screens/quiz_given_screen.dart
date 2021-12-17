import 'dart:math';

import 'package:finance_app/Models/question_model.dart';
import 'package:finance_app/Models/verdict.dart';
import 'package:finance_app/Screens/quiz_screen.dart';
import 'package:flutter/material.dart';

class QuizGivenScreen extends StatefulWidget {
  QuizGivenScreen({Key? key, this.response}) : super(key: key);

  dynamic response;

  @override
  State<QuizGivenScreen> createState() => _QuizGivenScreenState();
}

class _QuizGivenScreenState extends State<QuizGivenScreen> {
  List<int> ans = [0, 0, 0];

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      if (i == 0) {
        ans[widget.response['Answer']] += 1;
      } else {
        ans[widget.response['Answer' + i.toString()]] += 1;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int temp = ans.reduce(max);
    List<QuestionModel> list = allQustions;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          TextButton.icon(
            icon: const Icon(
              Icons.chevron_left_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
            label: const Text(
              "Back",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(
              Icons.app_registration,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    isNew: true,
                  ),
                ),
              );
            },
            label: const Text(
              "Attempt Quiz Again",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              children: [
                Text(
                  verdict[ans.indexOf(temp)]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 27,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: ListTile(
                          title: const Text("Your Selected Answer Count"),
                          subtitle: Text(
                            "Option A : ${ans[0]}\nOption B : ${ans[1]}\nOption C : ${ans[2]}",
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                  label: const Text("More"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                String idx;
                if (index == 0) {
                  idx = "Answer";
                } else {
                  idx = "Answer" + index.toString();
                }
                return AnsweredTile(
                  item: list[index],
                  index: index,
                  ansIdx: widget.response[idx],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AnsweredTile extends StatelessWidget {
  const AnsweredTile({
    Key? key,
    required this.item,
    required this.index,
    required this.ansIdx,
  }) : super(key: key);

  final QuestionModel item;
  final int index;
  final int ansIdx;

  @override
  Widget build(BuildContext context) {
    TextStyle queStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${index + 1}.  " " ${item.question!}",
            style: queStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Selected Answer -",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            item.options![ansIdx].statement!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
