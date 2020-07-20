import 'package:avi/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import './user.dart';

class Users extends ChangeNotifier{
  List<User> users=[];

  void addUser(Map<String,String>data){
    final newUser=User(
      data['email'],
      data['name'],
      '0'
    );
    users.add(newUser);
    notifyListeners();
    DBHelper.insert('users',{'email':newUser.email,'name':newUser.name,'credits':newUser.credits});
  }

  Future<void> fetchAndsetUsers()async{
    final datalist=await DBHelper.getData('users');
    users=datalist.map((item) =>User(
      item['email'],
      item['name'],
      item['credits']
    )).toList();
    notifyListeners();
  }
  
  Future<void> updateUser(User usr){
    int i=0;
    for(i=0;i<users.length;i++){
      if(users[i].email==usr.email){
        break;
      }
    }
    users[i]=User(
      users[i].email,
      users[i].name,
      usr.credits
    );
    notifyListeners();
    DBHelper.update({'email':users[i].email,'name':users[i].name,'credits':users[i].credits});
  }

}