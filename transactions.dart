import 'package:flutter/material.dart';
import './transaction.dart';
import '../helpers/db_helper.dart';

class Transactions extends ChangeNotifier{
  List<Transaction> transactions=[];
  void addTransaction(Map<String,String>data){
    final newTrans=Transaction(
      DateTime.now().toString(),
      data['credits'],
      data['receiver']
    );
    transactions.add(newTrans);
    notifyListeners();
    DBHelper.insert1('transactions',{'id':newTrans.id,'credits':newTrans.credits,'receiver':newTrans.receiver});
  }

  Future<void> fetchAndSetTrans()async{
    final datalist=await DBHelper.getData1('transactions');
    transactions=datalist.map((trans) =>Transaction(
      trans['id'],
      trans['credits'],
      trans['receiver']
    )).toList();
    notifyListeners();
  }
}