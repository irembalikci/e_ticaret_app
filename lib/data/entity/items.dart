class Items {
  int id;
  String ad;
  String resim;
  String kategori;
  int fiyat;
  String marka;

  Items({
    required this.id,
    required this.ad,
    required this.resim,
    required this.kategori,
    required this.fiyat,
    required this.marka,
  });
  factory Items.fromJson(Map<String,dynamic>json){
    return Items(id: json["id"], ad: json["ad"], resim: json["resim"], 
    kategori: json["kategori"], fiyat: json["fiyat"], marka: json["marka"]);
  }
}