
class KullaniciModel {
  String ? kullaniciId;
  String ? kullaniciAd;
  String ? email;
  String  ? password;

  KullaniciModel( this.kullaniciId, this.kullaniciAd, this.email, this.password);

  KullaniciModel.fromJson(Map<String, dynamic> json) {
    kullaniciId = json['kullaniciId'];
    kullaniciAd = json['kullaniciAd'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kullaniciId'] = this.kullaniciId;
    data['kullaniciAd'] = this.kullaniciAd;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
