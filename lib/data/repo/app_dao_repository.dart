import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_ticaret_app/data/entity/items.dart';
import 'package:e_ticaret_app/data/entity/items_response.dart';
import 'package:e_ticaret_app/data/entity/orderedItems.dart';
import 'package:e_ticaret_app/data/entity/ordered_response.dart';

class AppDaoRepository {
  List<Items> parseItems(String response) {
    return ItemsResponse.fromJson(json.decode(response)).items;
  }

  List<Ordereditems> parseOrdered(String response) {
    try {
      return OrderedResponse.fromJson(json.decode(response)).orderedItems;
    } catch (e) {
      print("JSON parse hatası: $e");
      return [];
    }
  }

  List<Items> _cachedItems = [];

  Future<void> ordered(
    String ad,
    String resim,
    String kategori,
    int fiyat,
    String marka,
    int siparisAdeti,
    String kullaniciAdi,
  ) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php";
    var data = {
      "ad": ad,
      "resim": resim,
      "kategori": kategori,
      "fiyat": fiyat,
      "marka": marka,
      "kullaniciAdi": kullaniciAdi,
      "siparisAdeti": siparisAdeti,
    };
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("INSERT: ${response.data.toString()}");
  }

  Future<List<Ordereditems>> loadOrder(String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php";
    var response = await Dio().post(
      url,
      data: FormData.fromMap({"kullaniciAdi": kullaniciAdi}),
    );

    print("Gelen Cevap: ${response.data}");

    if (response.data.toString().trim().isEmpty ||
        response.data.toString().startsWith("<br")) {
      // Sunucu boş veya hatalı HTML dönmüş
      return [];
    }

    return parseOrdered(response.data.toString());
  }

  Future<List<Items>> loadItems() async {
    var url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php";
    var response = await Dio().get(url);
    return parseItems(response.data.toString());
  }

  Future<void> delete(String kullaniciAdi, int sepetId) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php";
    var data = {"sepetId": sepetId, "kullaniciAdi": kullaniciAdi};
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("DELETE: ${response.data.toString()}");
  }

  Future<List<Items>> search(String searchText) async {
    var items = await loadItems(); // ← senin var olan çağrın
    _cachedItems = items;
    return _cachedItems
        .where(
          (item) => item.ad.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
  }
}
