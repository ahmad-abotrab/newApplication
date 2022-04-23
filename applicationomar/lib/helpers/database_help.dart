import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '/models/Tasks/Tasks.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String taskstable = 'task_table';
  String columnID = 'id';
  String columTitle = 'title';
  String columnDate = 'date';
  String columPriority = 'priority';
  String columnStatus = 'status';
// initializing database

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }
// creating a path directory

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'To-do list.db';
    final toDoListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return toDoListDb;
  }

  // creating database
  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $taskstable($columnID INTEGER PRIMARY KEY AUTOINCREMENT, $columTitle TEXT,$columnDate TEXT,$columPriority TEXT,$columnStatus INTEGER)',
    );
  }

//get tasks from database

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(taskstable);
    return result;
  }
// getting map lists and converting each map to an object

  Future<List<Tasks>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Tasks> taskslist = [];
    taskMapList.forEach((taskmap) {
      taskslist.add(Tasks.fromMap(taskmap));
    });
    taskslist.sort((taskA, taskB) => taskA.dateTask.compareTo(taskB.dateTask));
    return taskslist;
  }

// adding tasks to database with database helper instead of raw insert query

  Future<int> insertTask(Tasks task) async {
    Database db = await this.db;
    final int result = await db.insert(taskstable, task.toMap());
    return result;
  }

  // updating tasks input with the colID equals to task id

  Future<int> updateTask(Tasks task) async {
    Database db = await this.db;
    final int result = await db.update(taskstable, task.toMap(),
        where: '$columnID = ?', whereArgs: [task.id]);
    return result;
  }
  // deleting tasks input with the colID equals to task id

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result =
        await db.delete(taskstable, where: '$columnID = ?', whereArgs: [id]);
    return result;
  }
}
