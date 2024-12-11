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
    String path = join(myPath,'ProjectDataBase.db');
    Database mydb = await openDatabase(path,version:Version,
    onCreate: (db,version)async{
     await db.execute(''' 
      CREATE TABLE IF NOT EXISTS Users (
        ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        Firstname TEXT NOT NULL,
        Lastname TEXT NOT NULL,
        age INTEGER NOT NULL,
        Email TEXT NOT NULL,
        UserName TEXT NOT NULL,
        Password TEXT NOT NULL,
        Image TEXT NOT NULL
      );
      ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Events (
        ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        Name TEXT NOT NULL,
        Description TEXT NOT NULL,
        Date TEXT NOT NULL,
        Location TEXT NOT NULL,
        UserID INTEGER NOT NULL,
        FOREIGN KEY (UserID) REFERENCES Users (ID)
          ON DELETE NO ACTION 
          ON UPDATE NO ACTION
      );
      ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Gifts (
        ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        Title TEXT NOT NULL,
        Description TEXT NOT NULL,
        Thumbnail TEXT NOT NULL,
        Brand TEXT NOT NULL,
        Category TEXT NOT NULL,
        Price REAL NOT NULL,
        Pledge INTEGER NOT NULL CHECK (Pledge IN (0, 1)),
        EventId INTEGER NOT NULL,
        FOREIGN KEY (EventId) REFERENCES Events (ID)
          ON DELETE NO ACTION 
          ON UPDATE NO ACTION
      );
      ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Friends (
        UserId INTEGER NOT NULL REFERENCES Users (ID),
        FriendId INTEGER NOT NULL REFERENCES Users (ID),
        PRIMARY KEY (UserId, FriendId)
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