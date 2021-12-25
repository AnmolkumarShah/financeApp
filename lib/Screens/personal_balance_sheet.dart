import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Models/Child%20Specific/education.dart';
import 'package:finance_app/Models/Child%20Specific/marriage.dart';
import 'package:finance_app/Models/Child%20Specific/post_graduation.dart';
import 'package:finance_app/Models/Child%20Specific/seed_capital.dart';
import 'package:finance_app/Models/balance_model.dart';
import 'package:finance_app/Models/dreams.dart';
import 'package:finance_app/Models/expenses.dart';
import 'package:finance_app/Models/loans.dart';
import 'package:finance_app/Models/parent_wellbeing.dart';
import 'package:finance_app/Models/passive_incode.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';

class PersonalBalanceSheet extends StatefulWidget {
  const PersonalBalanceSheet({Key? key}) : super(key: key);

  @override
  State<PersonalBalanceSheet> createState() => _PersonalBalanceSheetState();
}

class _PersonalBalanceSheetState extends State<PersonalBalanceSheet> {
  late InfiniteScrollController _controller;
  int _selectedIndex = 0;
  double? _itemExtent;
  double get screenWidth => MediaQuery.of(context).size.width;

  List<BalanceModel> list = [];
  static int count = 0;

  bool loading = false;

  bool isUpdate = false;
  List<dynamic> res = [];

  @override
  void initState() {
    super.initState();
    count = 0;
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    if (data['ch_name'] != "") {
      list.add(ChildEducation(num: 1, data: data));
      list.add(ChildPostGrad(num: 1, data: data));
      list.add(ChildMarriage(num: 1, data: data));
      list.add(ChildSeedCapital(num: 1, data: data));
    }
    if (data['ch_name1'] != "") {
      list.add(ChildEducation(num: 2, data: data));
      list.add(ChildPostGrad(num: 2, data: data));
      list.add(ChildMarriage(num: 2, data: data));
      list.add(ChildSeedCapital(num: 2, data: data));
    }
    list.add(Expenses());
    list.add(ParentWell());
    list.add(PassivIncome());
    list.add(Dreams(num: 1));
    list.add(PersonalLoans());
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 50;
  }

  @override
  void dispose() {
    list = [];
    count = 0;
    super.dispose();
  }

  func() {
    if (count > 0)
      return;
    else {
      init();
      count++;
    }
  }

  init() async {
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    int id = data['id'];
    List<dynamic> result = await Query.execute(
        query: 'select * from persoanal_bal where Profile_id = $id');
    if (result.isEmpty) {
      dynamic init_insert_res = await Query.execute(
          p1: '1',
          query: 'insert into persoanal_bal(Profile_id,uid) values($id,$id)');
      if (init_insert_res['status'] != 'success') {
        Navigator.pop(context);
        showSnakeBar(context, "Please Try Again After Some Time");
      }
    } else {
      list.forEach((element) {
        element.setValue(result[0]);
      });
      showSnakeBar(context, "Ready To Go");
      setState(() {
        isUpdate = true;
        res = result;
      });
    }
  }

  saveAll() async {
    bool finl = true;
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    int id = data['id'];
    setState(() {
      loading = true;
    });

    for (int i = 0; i < list.length; i++) {
      dynamic res = await Query.execute(p1: '1', query: list[i].save(id));
      if (res['status'] != 'success') {
        finl = false;
      }
    }

    if (finl == true) {
      showSnakeBar(context, "Balance Sheet Saved Successfully");
      Navigator.pop(context);
    } else {
      showSnakeBar(context,
          "There is some error in saving Balance Sheet, Try after some time");
    }

    setState(() {
      loading = false;
    });
  }

  String totalCalculation() {
    double temp = 0;
    list.forEach((element) {
      temp += element.calculate();
    });
    return temp.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
          future: func(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader.shimmer;
            }
            return InfiniteCarousel.builder(
                center: true,
                loop: false,
                itemCount: list.length,
                itemExtent: _itemExtent!,
                controller: _controller,
                onIndexChanged: (index) {
                  // list[_controller.selectedItem].save(1);
                  setState(() {});
                },
                itemBuilder: (context, itemIndex, realIndex) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      list[itemIndex].builder(),
                      itemIndex == list.length - 1
                          ? Card(
                              child: ListTile(
                                leading: Text("Total Deficit / Surplus"),
                                trailing: Text(totalCalculation()),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          list[itemIndex].canNew() == true
                              ? TextButton.icon(
                                  onPressed: () {
                                    try {
                                      BalanceModel temp =
                                          list[itemIndex].copy();
                                      if (isUpdate == true) {
                                        temp.setValue(res[0]);
                                      }
                                      list.insert(itemIndex + 1, temp);
                                      _controller.nextItem();
                                      setState(() {});
                                    } catch (e) {
                                      print(e);
                                      showSnakeBar(context, e.toString());
                                    }
                                  },
                                  icon: Icon(Icons.add),
                                  label: Text("Add"),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          itemIndex != list.length - 1
                              ? TextButton.icon(
                                  onPressed: () {
                                    _controller.nextItem();
                                  },
                                  icon: Icon(Icons.navigate_next),
                                  label: Text("Next"),
                                )
                              : loading == true
                                  ? Loader.circular
                                  : ElevatedButton.icon(
                                      onPressed: saveAll,
                                      icon: isUpdate == true
                                          ? const Icon(Icons.update)
                                          : const Icon(Icons.save_alt),
                                      label: isUpdate == true
                                          ? const Text("Update")
                                          : const Text("Save"),
                                    ),
                        ],
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
