import 'package:flutter/material.dart';
import 'package:staj_projesi/Comm/comHelper.dart';
import 'package:staj_projesi/KayitEkrani.dart';
import 'package:staj_projesi/VeriTabani/DbHelper.dart';
import 'package:staj_projesi/color_utils.dart';
import 'package:staj_projesi/Comm/getTextFormField.dart';
import 'package:staj_projesi/UrunEkle.dart';

class GirisEkrani extends StatefulWidget{
  const GirisEkrani({Key?key}) : super(key : key);
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani>{
  final _conmail = TextEditingController();
  final _conpassword =  TextEditingController();
  var dbHelper;
  @override
  void initState(){
    super.initState();
    dbHelper = DbHelper();
  }
  giris(){

    String em = _conmail.text;
    String pass = _conpassword.text;

    if(em.isEmpty){
      alertDialog(context, 'Lütfen E-Postanızı giriniz');
    } else if(pass.isEmpty){
      alertDialog(context, 'Lütfen Şifrenizi giriniz.');
    } else{
      dbHelper.getKullaniciGirisi(em,pass).then((UserData){
        if(UserData!=null)
          Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_)=> UrunEkle()),
                (Route<dynamic>route) => false,
          );  else{
          alertDialog(context,"Hata : Kullanıcı Bulunamadı");
        }
      }).catchError((error){
        print(error);
        alertDialog(context, "Hata : Giriş Hatası");
      });
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
      ],begin:Alignment.bottomCenter )),child : SingleChildScrollView(child:Padding(padding: EdgeInsets.fromLTRB(10, MediaQuery.of(context).size.height*0.1, 20, 0),
      child:Column(

        children: <Widget>[
          logoWidget("assests/images/botasslogo.png"),

          SizedBox(height: 5.0,),
          getTextFormField(
            controller: _conmail,
            hintName: 'E-posta',
            icon: Icons.person,
            isObscureText: false,),

          SizedBox(height: 5.0,),

          getTextFormField(
            controller: _conpassword,
            hintName: 'Şifre',
            icon: Icons.lock,
            isObscureText: true,
          ),

          SizedBox(height: 5.0,),


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
              child: Text('Giriş Yap'),
              onPressed: giris,
            ),
          ),
          Container(
              child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hesabınız yok mu ?    ",
                    style : TextStyle(color : Colors.red , fontWeight: FontWeight.bold),),
                  ElevatedButton(
                    style : ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onPrimary: Colors.white,
                      elevation: 0.0,
                    ),

                    child : Text('Kayıt Ol'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>KayitEkrani()));


                    },
                  )
                ],
              )


          ),

        ],
      ),),),),
    );
  }
}


Image logoWidget(String imageName){
  return Image.asset(
    imageName,
    fit : BoxFit.fitWidth,
    width :120,
    height : 150 ,
    color : Colors.red,
  );
}

