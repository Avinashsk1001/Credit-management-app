import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';

class RegisterUser extends StatelessWidget{
  static const rout='registeruser';
  final form=GlobalKey<FormState>();
  Map<String,String> det={
    'name':'',
    'email':''
  };
  
  @override
  Widget build(BuildContext context){
    void savedet(){
      if(form.currentState.validate()){
        form.currentState.save();
        Provider.of<Users>(context,listen:false).addUser(det);
        Navigator.of(context).pop();
    }
  }
    return Scaffold(
      appBar:AppBar(
        title:Text(
          'Register user'
        )
      ),
      body:Form(
        key:form,
        child: Padding(
          padding:EdgeInsets.all(50),
          child: ListView(
            children:[
              TextFormField(
                decoration:InputDecoration(
                  labelText:'Enter name'
                ),
                validator:(value){
                  if(value.isEmpty){
                    return 'This feild cannot be empty';
                  }else{
                    return null;
                  }
                },
                onSaved:(value){
                  det['name']=value;
                },
              ),
              TextFormField(
                decoration:InputDecoration(
                  labelText:'Enter emailid'
                ),
                validator:(value){
                  if(value.isEmpty){
                    return 'This feild cannot be empty';
                  }else{
                    return null;
                  }
                },
                onSaved:(value){
                  det['email']=value;
                },
              ),
              FlatButton(
                onPressed:savedet, 
                child:Text('Register User')
                )
            ]
          ),
        ),
      )
    );
  }
}