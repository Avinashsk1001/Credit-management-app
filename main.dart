import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/allusers.dart';
import './providers/users.dart';
import './providers/transactions.dart';
import './screens/registeruser.dart';
import './screens/make_transaction.dart';
import './screens/alltransactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider.value(value:Users()),
        ChangeNotifierProvider.value(value:Transactions())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:AllUsers() ,
        routes:{
          RegisterUser.rout:(ctx)=>RegisterUser(),
          MakeTransaction.rout:(ctx)=>MakeTransaction(),
          AllTransactions.rout:(ctx)=>AllTransactions()
        },
      ),
    );
  }
}
