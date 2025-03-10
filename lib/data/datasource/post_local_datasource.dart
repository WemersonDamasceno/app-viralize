import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:viralize/data/models/post_mode.dart';

class PostLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE posts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            body TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertPost(PostModel post) async {
    final db = await database;
    await db.insert('posts', post.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PostModel>> getPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'posts',
      orderBy: 'id DESC',
    );

    return List.generate(maps.length, (i) {
      return PostModel.fromJson(maps[i]);
    });
  }
}
