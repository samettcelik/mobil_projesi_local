class UrunModel {
  String ? id;
  String ? adi;
  String ? sayisi;

  UrunModel({ this.id,  this.adi,  this.sayisi});

  factory UrunModel.fromJson(Map<String, dynamic> json) => UrunModel(
    id: json['id'],
    adi: json['adi'],
    sayisi: json['sayisi'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adi'] = this.adi;
    data['sayisi'] = this.sayisi;
    return data;
  }
}
