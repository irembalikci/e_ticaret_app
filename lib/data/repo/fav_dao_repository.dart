import 'package:e_ticaret_app/data/db/fav_database.dart';
import 'package:e_ticaret_app/data/entity/favorites.dart';

class FavoritesDaoRepository {
  Future<void> save(
    String ad,
    String resim,
    String kategori,
    int fiyat,
    String marka,
  ) async {
    var db = await DatabaseHelper.veritabaniErisim();
    var newFav = Map<String, dynamic>();
    newFav["ad"] = ad;
    newFav["resim"] = resim;
    newFav["kategori"] = kategori;
    newFav["fiyat"] = fiyat;
    newFav["marka"] = marka;

    await db.insert("favorites", newFav);
  }

  Future<void> delete(int id) async {
    var db = await DatabaseHelper.veritabaniErisim();
    await db.delete("favorites", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Favorites>> loadFavorites() async {
    var db = await DatabaseHelper.veritabaniErisim();
    List<Map<String, dynamic>> list = await db.rawQuery(
      "SELECT * FROM favorites",
    );

    return List.generate(list.length, (index) {
      var row = list[index];
      var id = row["id"];
      var ad = row["ad"];
      var resim = row["resim"];
      var kategori = row["kategori"];
      var fiyat = row["fiyat"];
      var marka = row["marka"];
      return Favorites(
        id: id,
        ad: ad,
        resim: resim,
        kategori: kategori,
        fiyat: fiyat,
        marka: marka,
      );
    });
  }

  Future<bool> isFavorite(String ad) async {
    var db = await DatabaseHelper.veritabaniErisim();
    var result = await db.query("favorites", where: "ad = ?", whereArgs: [ad]);
    return result.isNotEmpty;
  }
}
