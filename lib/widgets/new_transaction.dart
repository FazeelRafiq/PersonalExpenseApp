import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/database/database.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/transactionmodel_class.dart';
import '../main.dart';

class NewTransaction extends StatefulWidget {
  // final Function addTx;
  //
  // NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  DBHelper dbHelper;

  _validation(){
    // print(_selectedDate.toString());
    print(DateTime.now());
    if(formKey.currentState.validate()){
      Fluttertoast.showToast(msg: "You can Add Your Transaction");
      print("You can add you Transaction");
      print("title ${_titleController.text}");
      print("amount ${_amountController.text}");
      print("date ${_selectedDate}");
      dbHelper?.insert(
          TransactionModelClass(
            title: _titleController.text.toString(),
            amount: int.parse(_amountController.text.toString()),
            date: DateFormat.yMMMd().format(_selectedDate),
          )
      )?.then((value) {
        print("Data Added");
        Fluttertoast.showToast(msg: "Data Added");
      })?.onError((error, stackTrace) {
        print(error.toString());
      });
    }else{
      Fluttertoast.showToast(msg: 'Please Provide the required information');
      print("Enter The Information in the Textfields");
    }

  }
  

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
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.purple.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.withOpacity(0.8),
        title: const Text(
          "Add New Transactions",
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
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Title'),
                          controller: _titleController,
                          // onTap: _submitData,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Provide Your Amount";
                            }
                            return null;
                          }               // onChanged: (val) {
                        //   titleInput = val;
                        // },
                      ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Amount (Rs)'),
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          // onTap: _submitData,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Provide Your Amount";
                            }
                            return null;
                          }
                        // onChanged: (val) => amountInput = val,
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _selectedDate == null
                                    ? 'No Date Chosen!'
                                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                              child: Text(
                                'Choose Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: _presentDatePicker,
                            ),
                          ],
                        ),

                      ),

                      ElevatedButton(
                        child: Text('Add Transaction'),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                        onPressed: () {
                          _validation();
                          Navigator.of(context).pop();
                        },
                        //     () {
                        //   _submitData();
                        // },
                      ),
                    ],
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
