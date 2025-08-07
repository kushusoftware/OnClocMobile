import 'package:on_cloc_mobile/app/models/project/job_priority.dart';
import 'package:on_cloc_mobile/app/models/tracking/work_tracking.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OnClocDatabaseContext {
  static final OnClocDatabaseContext instance = OnClocDatabaseContext._init();
  static Database? _database;
  OnClocDatabaseContext._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('on_cloc.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    // const longTextType = 'VARCHAR NOT NULL';
    //const doubleType = 'REAL NOT NULL';

    const startCreateTable = 'CREATE TABLE IF NOT EXISTS';

    await db.execute('''$startCreateTable $workTrackingTable ( 
      ${WorkTrackingFields.workTrackingId} $idType,
      ${WorkTrackingFields.status} $textType,
      ${WorkTrackingFields.accuracy} $textType,
      ${WorkTrackingFields.activity} $textType,
      ${WorkTrackingFields.latitude} $textType,
      ${WorkTrackingFields.longitude} $textType,
      ${WorkTrackingFields.altitude} $integerType,
      ${WorkTrackingFields.heading} $integerType,
      ${WorkTrackingFields.speed} $integerType,
      ${WorkTrackingFields.time} $integerType,
      ${WorkTrackingFields.isMock} $boolType,
      ${WorkTrackingFields.batteryPercentage} $textType,
      ${WorkTrackingFields.isGpsEnabled} $boolType,
      ${WorkTrackingFields.isWifiEnabled} $boolType,
      ${WorkTrackingFields.signalStrength} $textType,
      ${WorkTrackingFields.isSynced} $boolType,
      ${WorkTrackingFields.createdAt} $textType
    )''');

    await db.execute('''$startCreateTable $jobPriorityTable (
      ${JobPriorityFields.jobPriorityLevelId} $idType,
      ${JobPriorityFields.priorityIndex} $integerType,
      ${JobPriorityFields.priorityLevel} $textType,
      ${JobPriorityFields.colourCode} $textType,
      ${JobPriorityFields.isSynced} $boolType,
    )''');
  }

  Future deleteDB() async {
    final db = await instance.database;
    db.delete(workTrackingTable);
  }
}