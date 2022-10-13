import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tarefa.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'taskxp.db'),
      version: 2,
      onCreate: _onCreate,
    );
  }
  _onCreate(db, versao) async {
    await db.execute(_tarefa);
    await db.execute(_lixeira);
  }
  String get _tarefa => '''
    CREATE TABLE tarefa (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT,
      data INT,
      descricao TEXT,
      finalizado INT
    );
  ''';

  String get _lixeira => '''
    CREATE TABLE lixeira (
      id INTEGER PRIMARY KEY,
      titulo TEXT,
      data INT,
      descricao TEXT,
      finalizado INT
    );
  ''';

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Tarefa> criarTarefa(String tabela, Tarefa t) async {
    final db = await instance.database;
    t.id = await db.insert(tabela, t.toMap());
    return t;
  }

  Future<Tarefa> lerTarefa(String tabela, int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tabela,
      columns: ['id', 'titulo', 'data', 'descricao', 'finalizado'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Tarefa.fromMap(maps.first);
    }
    else {
      throw Exception('ID $id não encontrado');
    }
  }

  Future<List<Tarefa>> lerTodasTarefas(String tabela) async {
    final db = await instance.database;

    final result = await db.query(tabela);

    if(result.isNotEmpty){
      return result.map<Tarefa>((t) => Tarefa.fromMap(t)).toList();
    }
    else {
      return [];
    }
  }

  Future<int> update(String tabela, Tarefa t) async {
    final db = await instance.database;

    return await db.update(
      tabela,
      t.toMap(),
      where: 'id = ?',
      whereArgs: [t.id],
    );
  }

  Future<int> delete(String tabela, int id) async {
    final db = await instance.database;

    return await db.delete(
      tabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}