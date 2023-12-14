import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/database/transactionmodel_class.dart';
import 'package:flutter_complete_guide/main.dart';
import 'package:intl/intl.dart';
import 'database.dart';

class TransactionDbList extends StatefulWidget {
  const TransactionDbList({Key key}) : super(key: key);

  @override
  State<TransactionDbList> createState() => _TransactionDbListState();
}

class _TransactionDbListState extends State<TransactionDbList> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  Future<List<TransactionModelClass>> transactionList;
  DBHelper dbHelper;
  String selectGender = 'male';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    transactionList = dbHelper.getCartListWithUserId();
  }

  // Update Data

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;

      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    print("List $transactionList");
    print("List ${dbHelper.getCartListWithUserId()}");
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.withOpacity(0.8),
        title: const Text(
          "Transactions List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: FutureBuilder(
              future: transactionList,
              builder: (context,
                  AsyncSnapshot<List<TransactionModelClass>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      print("Snapshot ${snapshot.data.length}");
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Padding(padding: EdgeInsets.all(6),
                              child: FittedBox(
                                child: Text(
                                  "RS ${snapshot.data[index].amount.toString()}",
                                ),
                              ),
                              ),
                            ),
                            title: Text(
                              snapshot.data[index].title.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 17
                              ),
                            ),
                            subtitle: Text(
                              // DateFormat.yMMMd().format(snapshot.data[index].date.toString() as DateTime),

                              "Date :  ${snapshot.data[index].date.toString()}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).colorScheme.error,
                              onPressed: () {
                                setState(() {
                                  dbHelper?.delete(
                                      snapshot
                                          .data[
                                      index]
                                          .id);
                                  // For Refreshing List
                                  transactionList =
                                      dbHelper
                                          .getCartListWithUserId();
                                  snapshot.data
                                      .remove(snapshot
                                      .data[
                                  index]);

                                });
                              },
                            ),
                          ),


                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
