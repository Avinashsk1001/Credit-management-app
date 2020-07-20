import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transactions.dart';

class AllTransactions extends StatelessWidget{
  static const rout='alltransactions';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('All Transactions'),
      ),
      body:FutureBuilder(
        future:Provider.of<Transactions>(context,listen:false).fetchAndSetTrans(),
        builder:(ctx,snapshot)=>
        snapshot.connectionState==ConnectionState.waiting?
        Center(
          child:CircularProgressIndicator(),
        ):
        Consumer<Transactions>(
          child:Center(child:Text('There are no transactions currently')
          ),
          builder:(ctx,tr,ch)=>
          tr.transactions.length<=0?ch:
          ListView.builder(
            itemCount:tr.transactions.length,
            itemBuilder:(ctx,i)=>
            ListTile(
              title:Text(
                tr.transactions[i].receiver,style:TextStyle(
                  fontWeight:FontWeight.bold,fontSize:20
                ),
              ),
              leading:Text(
                tr.transactions[i].credits,style:TextStyle(
                  fontWeight:FontWeight.bold,fontSize:20
                ),
              ),
            )
            ),
        )
        ) ,
    );
  }
}