import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import 'database/transactiondb_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          // errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  subtitle1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  // void _startAddNewTransaction() {
  //   // showModalBottomSheet(
  //   //   context: ctx,
  //   //   builder: (_) {
  //   //     return GestureDetector(
  //   //       onTap: () {},
  //   //       child: NewTransaction(_addNewTransaction),
  //   //       behavior: HitTestBehavior.opaque,
  //   //     );
  //   //   },
  //   // );
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => NewTransaction(),
  //   fullscreenDialog: true,
  //     maintainState: true,
  //   ),
  //   );
  //
  // }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Personal Expenses',
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => NewTransaction()));
        //     }
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.abc),
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDbList()));
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //  Chart(_recentTransactions),
            //TransactionDbList(),
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 130,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black, width: 5)),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewTransaction()));
                          },
                          child: Image.asset(
                            'assets/images/add.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Add Transaction',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black, width: 5)),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransactionDbList()));
                          },
                          child: Image.asset(
                            'assets/images/images.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Transactions List',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),


            // TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => NewTransaction()));
      //   }
      // ),
    );
  }
}
