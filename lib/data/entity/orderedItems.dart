class Ordereditems {
  int sepetId;
  String ad;
  String resim;
  String kategori;
  int fiyat;
  String marka;
  int siparisAdeti;  
  String kullaniciAdi="irembalikci";


  Ordereditems({
    required this.ad,
    required this.resim,
    required this.kategori,
    required this.fiyat,
    required this.marka,
    required this.kullaniciAdi,
    required this.sepetId,
    required this.siparisAdeti
  });
  factory Ordereditems.fromJson(Map<String,dynamic>json){
    return Ordereditems(sepetId: json["sepetId"], ad: json["ad"], resim: json["resim"], 
    kategori: json["kategori"], fiyat: json["fiyat"], marka: json["marka"], siparisAdeti: json["siparisAdeti"], kullaniciAdi: json["kullaniciAdi"]);
  }
}