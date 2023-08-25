import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:staj_projesi/Model/KullaniciModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:staj_projesi/Model/UrunModel.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;

  static Database? _db;

  DbHelper.internal();

  String tblKullanici = 'Kullanici';
  String colId = 'id';
  String colKullaniciId = 'kullaniciId';
  String colKullaniciAd = 'kullaniciAd';
  String colEmail = 'email';
  String colPassword = 'password';

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await _initializeDatabase();
    return _db;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tblKullanici($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' $colKullaniciId TEXT, $colKullaniciAd TEXT, $colEmail TEXT, $colPassword TEXT)',
    );

    await db.execute(
      'CREATE TABLE $tblUrunler($colUrunId INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' $colUrunAdi TEXT, $colUrunSayisi TEXT)',
    );
  }

  Future<int> saveData(KullaniciModel kullanici) async {
    var dbClient = await db;
    int res = await dbClient!.insert(tblKullanici, kullanici.toJson());
    return res;
  }

  Future<List<KullaniciModel>> getKullanicilar() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient!.query(tblKullanici);
    List<KullaniciModel> kullaniciList = [];
    for (int i = 0; i < list.length; i++) {
      var kullanici = KullaniciModel.fromJson(Map<String, dynamic>.from(list[i]));
      kullaniciList.add(kullanici);
    }
    return kullaniciList;
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    int res = await dbClient!.delete(tblKullanici, where: '$colId = ?', whereArgs: [id]);
    return res;
  }

  Future<int> updateData(KullaniciModel kullanici) async {
    var dbClient = await db;
    int res = await dbClient!.update(
      tblKullanici,
      kullanici.toJson(),
      where: '$colKullaniciId = ?',
      whereArgs: [kullanici.kullaniciId],
    );
    return res;
  }

  Future<KullaniciModel?> getKullaniciGirisi(String email, String password) async {
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient!.query(
      tblKullanici,
      where: '$colEmail = ? AND $colPassword = ?',
      whereArgs: [email, password],
    );
    if (list.isNotEmpty) {
      return KullaniciModel.fromJson(Map<String, dynamic>.from(list.first));
    } else {
      return null;
    }
  }

  String tblUrunler = 'urunler'; // Tablo adı, 'urunler' tablosu için
  String colUrunId = 'id'; // 'id' sütun adı
  String colUrunAdi = 'adi'; // 'adi' sütun adı
  String colUrunSayisi = 'sayisi'; // 'sayisi' sütun adı

  Future<int> insertUrun(String id, String adi, String sayisi) async {
    final db = await _initializeDatabase();
    return await db.insert(
      tblUrunler,
      {
        colUrunId: id,
        colUrunAdi: adi,
        colUrunSayisi: sayisi,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

    Future<Database> _initializeDatabase() async {
      Directory directory = await getApplicationDocumentsDirectory();
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

    String path = join(directory.path, 'kullanici.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDb);

    return db;
  }


  Future<List<UrunModel>> getUrunlerForUser(String urunId) async {
      final db = await _initializeDatabase();
      List<Map<String, dynamic>> list = await db.query(
        tblUrunler,
        where: '$colUrunId= ?',
        whereArgs: [urunId],
      );

    List<UrunModel> urunList = [];
    for (int i = 0; i < list.length; i++) {
      var urun = UrunModel.fromJson(Map<String, dynamic>.from(list[i]));
      urunList.add(urun);
    }
    return urunList;
  }
}
