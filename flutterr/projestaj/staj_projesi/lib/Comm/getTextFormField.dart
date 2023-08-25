import 'package:flutter/material.dart';
import 'package:staj_projesi/color_utils.dart';
import 'package:staj_projesi/Comm/comHelper.dart';
class getTextFormField extends StatelessWidget{
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;

  getTextFormField(
      { required this.controller, required this.hintName, required this.icon,this.isObscureText=false,this.inputType=TextInputType.text});
  @override
  Widget build(BuildContext context){
    return Container(
        padding : EdgeInsets.symmetric(horizontal:20.0),
        margin : EdgeInsets.only(top:10.0),
        child : TextFormField(
          controller : controller,
          obscureText: isObscureText,
          keyboardType: inputType,
          validator : (value){
            if(value == null || value.isEmpty){
              return 'Lütfen $hintName Giriniz';
            }
            if(hintName=="E-Posta"&&!validateEmail(value)){
              return 'Lütfen geçerli bir e-posta girin.';
            }
            return null;

          },

         decoration: InputDecoration(
           // Giriş alanının kenarlık düzenlemesi
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)), // Kenarlık köşelerini yuvarlama
              borderSide: BorderSide(color : Colors.transparent),),// Kenarlık rengini şeffaf yapma
            focusedBorder : OutlineInputBorder(   // Giriş alanına odaklanıldığında kenarlık düzenlemesi
            borderRadius: BorderRadius.all(Radius.circular(30.0)),// Kenarlık köşelerini yuvarlama
              borderSide: BorderSide(color : Colors.blue),// Kenarlık rengini mavi yapma
            ),
            prefixIcon : Icon(Icons.person),// Giriş alanının önüne "person" simgesini eklemek
            hintText: hintName, // Giriş alanında gösterilecek ipucu metni
            labelText: hintName, // Giriş alanının etiketi olarak gösterilecek metin
            fillColor :  hexStringToColor("#D8DCE4"),// Giriş alanının dolgu rengi
            filled:true, // Giriş alanının dolgulu olup olmadığı
          ),


        )
    );
  }
}