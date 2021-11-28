class QuestionModel {
  String? question;
  List<Option>? options;
  bool isAnswered = false;

  QuestionModel({this.options, this.question});

  clearAll() {
    for (var element in options!) {
      element.unselect();
    }
    isAnswered = false;
  }

  markAnswered() {
    isAnswered = true;
  }

  finalAns() {
    int idx = options!.indexWhere((element) => element.isSelected());
    return idx;
  }
}

class Option {
  String? statement;
  bool? selected;
  Option(this.statement, {this.selected = false});
  void unselect() {
    selected = false;
  }

  void select(bool? prev) {
    selected = !prev!;
  }

  bool isSelected() {
    if (selected == true) {
      return true;
    } else {
      return false;
    }
  }
}

List<QuestionModel> allQustions = [
  QuestionModel(
    question:
        "HOW LIQUID ARE YOUR SAVINGS WHICH COULD BE AVAILED EASILY IN ANY EMERGENCY?",
    options: [
      Option(
        "No, I might have to borrow.",
      ),
      Option("I have liquid money but not sure whether it will be enough."),
      Option(
          "Yes, I have sufficient liquid savings to handle any emergency and can be accessed easily"),
    ],
  ),
  QuestionModel(
    question:
        "IN THE EVENT OF A JOB LOSS, HOW MANY MONTHS OF YOUR REGULAR HOUSEHOLD EXPENSES YOU CAN BEAR WITHOUT HAVING ANY FRESH INCOME?",
    options: [
      Option("No, I am fully dependent on monthly income."),
      Option("1-3 months."),
      Option("6 months or more."),
    ],
  ),
  QuestionModel(
    question: "DO YOU HAVE ADEQUATE HEALTH INSURANCE FOR SELF and FAMILY?",
    options: [
      Option("No, I do not have health insurance."),
      Option(
          "Yes, me and family are covered by my employer but not sure if it is adequate."),
      Option(
          "Yes, me and family have adequate personal health insurance and covered by employer too."),
    ],
  ),
  QuestionModel(
    question:
        "DO YOU THINK YOUR DEPENDENTS WOULD HAVE ENOUGH MONEY IN YOUR ABSENCE?",
    options: [
      Option("No, I do not have health insurance."),
      Option(
          "No, I have not thought about it and I do not have any life insurance either."),
      Option(
          "I have liquid money but not sure whether it will be enough.Yes, I have sufficient liquid savings to handle any emergency and can be accessed easily"),
    ],
  ),
  QuestionModel(
    question:
        "WHAT PERCENTAGE (%) OF YOUR MONTHLY INCOME GOES TOWARDS PAYMENT OF EMIS? (HOME LOAN, CAR LOAN, PERSONAL LOAN, CREDIT CARD LOAN ETC.)?",
    options: [
      Option("More than 35%."),
      Option("Not more than 35%."),
      Option("I do not have any loans."),
    ],
  ),
  QuestionModel(
    question: "ARE YOU ABLE TO MANAGE YOUR LOANS?",
    options: [
      Option("I am struggling to repay."),
      Option("I can afford EMI but it affects my savings which is limited."),
      Option(
          "I not only comfortably pay EMIs but also periodically prepay the principal / I am Debt Free, i.e. having Zero Debt."),
    ],
  ),
  QuestionModel(
    question: "ARE YOU ABLE TO SAVE REGULARLY?",
    options: [
      Option("I am unable to save money."),
      Option("I have to struggle to save money."),
      Option("I am able to comfortably save on a regular basis."),
    ],
  ),
  QuestionModel(
    question: "DO YOU INVEST YOUR MONTHLY SAVINGS REGULARLY?",
    options: [
      Option("No, I invest when huge savings accumulate in my bank account."),
      Option("Sometimes, when there is an opportunity to save tax."),
      Option("Yes, I invest on a monthly basis."),
    ],
  ),
  QuestionModel(
    question: "HAVE YOU MAPPED YOUR CURRENT INVESTMENTS TO SPECIFIC GOALS?",
    options: [
      Option(
          "No, most of my investments are done with the objective of saving tax."),
      Option(
          "No, my investments are done on an AD HOC basis with no goal in mind."),
      Option("Yes, most of my investments are aligned with specific goals."),
    ],
  ),
  QuestionModel(
    question: "WHERE DO YOU INVEST?",
    options: [
      Option(
          "Fixed deposit, recurring deposit, post saving schemes (Fixed income options)."),
      Option("(a)+ gold, properties."),
      Option("(a)+(b), equity, mutual funds, annuities"),
    ],
  ),
];
