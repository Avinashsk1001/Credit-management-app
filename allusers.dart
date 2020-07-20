import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import './registeruser.dart';
import './make_transaction.dart';
import './alltransactions.dart';

class AllUsers extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('All Users'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.add), 
            onPressed:(){
              Navigator.of(context).pushNamed(RegisterUser.rout);
            }),
          FlatButton(
            onPressed:(){
              Navigator.of(context).pushNamed(AllTransactions.rout);
            } ,
            child:Text('View all transactions'))
        ],
      ),
      body:FutureBuilder(
        future:Provider.of<Users>(context,listen:false).fetchAndsetUsers(),
        builder:(ctx,snapshot)=>
        snapshot.connectionState==ConnectionState.waiting?
        Center(
          child:CircularProgressIndicator(),
        ):
        Consumer<Users>(
          child:Center(child:Text('There are no users currently')
          ),
          builder:(ctx,us,ch)=>
          us.users.length<=0?ch:
          ListView.builder(
            itemCount:us.users.length,
            itemBuilder:(ctx,i)=>
            ListTile(
              onTap:(){
                Navigator.of(context).pushNamed(
                  MakeTransaction.rout,
                  arguments:us.users[i]
                  );
              },
              title:Text(
                us.users[i].name,style:TextStyle(
                  fontWeight:FontWeight.bold,fontSize:20
                ),
              ),
              leading:Text(
                us.users[i].credits,style:TextStyle(
                  fontWeight:FontWeight.bold,fontSize:20
                ),
              ),
              subtitle:Text(
                us.users[i].email,style:TextStyle(
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