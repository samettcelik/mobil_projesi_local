import 'package:flutter/material.dart';
import 'package:staj_projesi/Comm/comHelper.dart';
import 'package:staj_projesi/GirisEkrani.dart';
import 'package:staj_projesi/Model/KullaniciModel.dart';
import 'package:staj_projesi/color_utils.dart';
import 'package:staj_projesi/Comm/getTextFormField.dart';
import 'package:staj_projesi/VeriTabani/DbHelper.dart';
import 'package:toast/toast.dart';
import 'package:staj_projesi/Comm/comHelper.dart'as com;


class KayitEkrani extends StatefulWidget{
  const KayitEkrani({Key?key}) : super(key : key);
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani>{
  final _formKey = new GlobalKey<FormState>();
  final _conkullanicid = TextEditingController();
  final _conkullanicad = TextEditingController();
  final _conemail = TextEditingController();
  final _conpassword =  TextEditingController();
  final _confirmpassword = TextEditingController();
  var dbHelper;
  @override
  void initState(){
    super.initState();
    dbHelper = DbHelper();
  }

  kayitOl() async {

    final form = _formKey.currentState;
    String kid = _conkullanicid.text;
    String kad = _conkullanicad.text;
    String em = _conemail.text;
    String pass = _conpassword.text;
    String cpass = _confirmpassword.text;

    if (form!.validate()) {
      if (pass != cpass) {
        alertDialog(context, 'Şifre Eşleşmiyor');
      } else {
        var kullanici = KullaniciModel(kid,  kad,  em, pass);
        int result = await dbHelper.saveData(kullanici);

        if (result != 0) {
          alertDialog(context, "Başarıyla Kaydedildi");

          // Kayıt işlemi tamamlandıktan sonra girisEkranina yönlendirme yapabilirsiniz.
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => GirisEkrani()),
                (Route<dynamic>route) => false,
          );
        } else {
          alertDialog(context, "Hata: Kayıt İşlemi Başarısız");
        }




      }
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(body: Container(

      width : MediaQuery.of(context).size.width,
      height : MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: LinearGradient(colors:[
        hexStringToColor("#F5F5F5"),
        hexStringToColor("#F5FEFD"),
        hexStringToColor("#FAEBD7"),
      ],begin:Alignment.bottomCenter )),child : SingleChildScrollView(child:Padding(padding: EdgeInsets.fromLTRB(5, MediaQuery.of(context).size.height*0.05, 10, 0),
      child : Form(
        key:_formKey,
        child:Column(
          children: <Widget>[
            logoWidget("assests/images/kayitol.png"),
            Text("\n"),

            getTextFormField(
                controller: _conkullanicid,
                hintName: 'Kullanıcı ID',
                icon: Icons.person),
            SizedBox(height: 5.0),

            getTextFormField(
                controller: _conkullanicad,
                hintName: 'Kullanıcı Adı',
                inputType: TextInputType.name,
                icon: Icons.person_outlined),
            SizedBox(height: 5.0),

            getTextFormField(
                controller: _conemail,
                hintName: 'E-Posta',
                inputType: TextInputType.emailAddress,
                icon: Icons.mail),

            getTextFormField(
                controller: _conpassword,
                hintName: 'Şifre',
                isObscureText: true,
                icon: Icons.lock),
            SizedBox(height: 5.0),


            getTextFormField(
              controller: _confirmpassword,
              hintName: 'Şifreyi Doğrula',
              icon: Icons.lock,
              isObscureText: true,),

            SizedBox(height: 5.0),

            Container(
              margin: EdgeInsets.all(20.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700],
                  onPrimary: Colors.white,
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Kayıt Ol'),
                onPressed: kayitOl ,
              ),
            ),
            Container(
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hesabınız var mı ?    ",
                      style : TextStyle(color : Colors.red , fontWeight: FontWeight.bold),),
                    ElevatedButton(
                      style : ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.white,
                        elevation: 0.0,
                      ),

                      child : Text('Giriş Yap'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>GirisEkrani()),
                                (Route<dynamic>route)=>false);
                      },
                    )
                  ],
                )

            ),

          ],
        ),),),),),
    );
  }
}


Image logoWidget(String imageName){
  return Image.asset(
    imageName,
    fit : BoxFit.fitWidth,
    width :100,
    height : 100 ,
    color : Colors.red,
  );
}
