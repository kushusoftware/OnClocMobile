import 'package:on_cloc_mobile/app/models/project/job_priority.dart';
import 'package:on_cloc_mobile/data/database_context.dart';

class JobPriorityService {
  static final OnClocDatabaseContext instance = OnClocDatabaseContext.instance;

  // Job Priority Service
  Future<JobPriority> createJobPriority(JobPriority jobPriority) async {
    final db = await instance.database;

    final jobPriorityLevelId = await db.insert(jobPriorityTable, jobPriority.toJson());
    return jobPriority.copy(jobPriorityLevelId: jobPriorityLevelId);
  }

  Future<List<JobPriority>> getAllJobPriorityList() async {
    final db = await instance.database;

    final maps = await db.query(
      jobPriorityTable,
      where: '${JobPriorityFields.isSynced} = ?',
      whereArgs: [false],
    );

    if (maps.isNotEmpty) {
      return maps.map((model) => JobPriority.fromJson(model)).toList();
    } else {
      return [];
    }
  }

  Future<int> confirmJobPrioritySync(JobPriority jobPriority) async {
    final db = await instance.database;

    return db.update(
      jobPriorityTable,
      jobPriority.toJson(),
      where: '${JobPriorityFields.jobPriorityLevelId} = ?',
      whereArgs: [jobPriority.jobPriorityLevelId],
    );
  }

  Future<int> deleteJobPriority() async {
    final db = await instance.database;

    return await db.delete(
      jobPriorityTable,
      where: '${JobPriorityFields.isSynced} = ?',
      whereArgs: [true],
    );
  }

  Future<int> syncJobPriorityCount() async {
    final db = await instance.database;
    
    final jobPriorities = await db.query(
      jobPriorityTable,
      where: '${JobPriorityFields.isSynced} = ?',
      whereArgs: [0],
    );

    return jobPriorities.length;
  }
}