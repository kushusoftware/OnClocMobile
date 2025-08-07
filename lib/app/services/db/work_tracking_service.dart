import 'package:on_cloc_mobile/app/models/tracking/work_tracking.dart';
import 'package:on_cloc_mobile/data/database_context.dart';

class WorkTrackingService {
  static final OnClocDatabaseContext instance = OnClocDatabaseContext.instance;

  // Tracking Service
  Future<WorkTracking> createWorkTracking(WorkTracking tracking) async {
    final db = await instance.database;

    final id = await db.insert(workTrackingTable, tracking.toJson());
    return tracking.copy(id: id);
  }

  Future<List<WorkTracking>> getAllWorkTrackingsList() async {
    final db = await instance.database;

    final maps = await db.query(
      workTrackingTable,
      where: '${WorkTrackingFields.isSynced} = ?',
      whereArgs: [false],
    );

    if (maps.isNotEmpty) {
      return maps.map((model) => WorkTracking.fromJson(model)).toList();
    } else {
      return [];
    }
  }

  Future<int> confirmWorkTrackingSync(WorkTracking tracking) async {
    final db = await instance.database;

    return db.update(
      workTrackingTable,
      tracking.toJson(),
      where: '${WorkTrackingFields.workTrackingId} = ?',
      whereArgs: [tracking.id],
    );
  }

  Future<int> deleteWorkTracking() async {
    final db = await instance.database;

    return await db.delete(
      workTrackingTable,
      where: '${WorkTrackingFields.isSynced} = ?',
      whereArgs: [true],
    );
  }

  Future<int> syncWorkTrackingCount() async {
    final db = await instance.database;
    
    final trackings = await db.query(
      workTrackingTable,
      where: '${WorkTrackingFields.isSynced} = ?',
      whereArgs: [0],
    );

    return trackings.length;  
  }
}