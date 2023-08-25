import 'package:flutter/material.dart';
import 'package:staj_projesi/VeriTabani/DbHelper.dart';

class UrunEkle extends StatefulWidget {
  @override
  _UrunEkleState createState() => _UrunEkleState();
}

class _UrunEkleState extends State<UrunEkle> {
  final _formKey = GlobalKey<FormState>();
  final _conID = TextEditingController();
  final _conAdi = TextEditingController();
  final _conSayisi = TextEditingController();

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  void urunEkle() {
    String id = _conID.text;
    String adi = _conAdi.text;
    String sayisi = _conSayisi.text;

    if (id.isEmpty || adi.isEmpty || sayisi.isEmpty) {
      // Gerekli alanları doldurmadıysa hata mesajı göster
      alertDialog(context, 'Lütfen tüm alanları doldurunuz.');
    } else {
      // Veritabanına ürünü ekleyin
      dbHelper.insertUrun(id, adi, sayisi).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        // Eğer bir hata oluşursa hata mesajı göster
        print(error);
        alertDialog(context, 'Hata: Ürün eklenemedi.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Ekle'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _conID,
                decoration: InputDecoration(labelText: 'Ürün ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bu alanı doldurun';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _conAdi,
                decoration: InputDecoration(labelText: 'Ürün Adı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bu alanı doldurun';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _conSayisi,
                decoration: InputDecoration(labelText: 'Ürün Sayısı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bu alanı doldurun';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    urunEkle();
                  }
                },
                child: Text('Ürünü Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uyarı'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
