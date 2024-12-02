import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseClass{
  static Database? _MyDataBase;
  int Version = 1;

  Future<Database?>get MyDataBase async{
    if(_MyDataBase==null)
      {
        _MyDataBase=await initialize();
        return _MyDataBase;
      }
    else{
      return _MyDataBase;
    }

  }

  initialize()async{
    
    String myPath = await getDatabasesPath();
    String path = join(myPath,'myDataBase.db');
    Database mydb = await openDatabase(path,version:Version,
    onCreate: (db,Version)async{
      db.execute(''' 
      Create Table If Not Exists "Users"(
      'ID' Integer Not null Primary Key AutoIncrement,
      'Firstname' Text not null,
      'Lastname' Text not null,
      'age' int not null,
      'Email' Text not null,
      'UserName' Text not null,
      'Password' Text not null,
      'Image' Text not null
      );
      
      Create Table If not exists 'Events'(
      'ID' Integer not null Primary key autoincrement,
      'Name' Text not null,
      'Description' Text not null,
      'Date' Text not null,
      'Location' Text not null,
      'UserID' Integer not null,
      Foreign key (UserID) REFERENCES Users (ID) on delete no action on update no action
      );
      
      Create Table If not exists 'Gifts'(
      'ID' Integer not null Primary key autoincrement,
      'Title' Text not null,
      'Description' Text not null,
      'Thumbnail' Text not null,
      'Brand' Text not null,
      'Category' Text not null,
      'Price' Double not null,
      'Pledge' Boolean not null,
      'EventId' Integer not null,
      Foreign key (EventId) REFERENCES Events (id) on delete no action on update no action
      );
      
      
      Create Table If not exists 'Friends'(
      'UserId' Integer REFERENCES Users(ID) not null ,
      'FriendId' Integer REFERENCES Users(ID) not null ,
      Primary key (UserId,FriendId)
      );
     
      ''');
      print("DATABASE HAS BEEN CREATED ........");
    });
    return mydb;

  }

  readData(String SQL)async{
    Database? mydata = await MyDataBase;
    var response = await mydata!.rawQuery(SQL);
    return response;
  }

  insertData(String SQL)async{
    Database? mydata = await MyDataBase;
    int response = await mydata!.rawInsert(SQL);
    return response;

  }


  deleteData(String SQL)async{
    Database? mydata = await MyDataBase;
    int response = await mydata!.rawDelete(SQL);
    return response;

  }

  updateData(String SQL)async{
    Database? mydata = await MyDataBase;
    int response = await mydata!.rawUpdate(SQL);
    return response;

  }


}