import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/users.dart';
import '../providers/transactions.dart';

class MakeTransaction extends StatelessWidget{
  static const rout='maketransaction';
  final form=GlobalKey<FormState>();
  String credits='';
  @override
  Widget build(BuildContext context){
    final usr=ModalRoute.of(context).settings.arguments as User;
    void savedet(){
      if(form.currentState.validate()){
        form.currentState.save();
        final user=User(
          usr.email, 
          usr.name, 
          (double.parse(usr.credits)+double.parse(credits)).toString()
          );
        Provider.of<Users>(context,listen:false).updateUser(user);
        Provider.of<Transactions>(context,listen:false).addTransaction({'credits':credits,'receiver':usr.name});
        Navigator.of(context).pop();
      }
    }
    return Scaffold(
      appBar:AppBar(
        title:Text(
          usr.name
        ),
      ),
      body:SingleChildScrollView(
        child:Padding(
          padding:EdgeInsets.all(40),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children:[
                SizedBox(
                  height:40
                ),
                Text(
                  'Current Credits',
                  style:TextStyle(
                    fontSize:20,fontWeight:FontWeight.bold
                  ),
                ),
                Text(
                  usr.credits,
                  style:TextStyle(
                    fontSize:20,fontWeight:FontWeight.bold
                  ),
                ),
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'No. of credits'
                  ),
                  validator:(value){
                    if(value.isEmpty){
                      return 'Give a valid input';
                    }else{
                      return null;
                    }
                  },
                  keyboardType:TextInputType.number,
                  onSaved:(value){
                    credits=value;
                  },
                ),
                FlatButton(
                  onPressed: savedet, 
                  child:Text(
                    'Make Transaction'
                  )
                  )
              ]
            ),
          ),
        )
      ) ,
    );
  }
}