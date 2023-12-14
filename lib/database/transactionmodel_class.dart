class TransactionModelClass {
  final int id;
  final String title;
  final int amount;
  final String date;

  TransactionModelClass({
    this.id,
    this.title,
    this.amount,
    this.date,
  });

  TransactionModelClass.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        amount = res["amount"],
        date = res["date"];


  Map<String, Object> toMap() {
    return {'id':id,'title': title, 'amount': amount, 'date': date,};
  }
}