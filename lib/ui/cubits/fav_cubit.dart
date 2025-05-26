import 'package:e_ticaret_app/data/entity/favorites.dart';
import 'package:e_ticaret_app/data/repo/fav_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<List<Favorites>> {
  FavCubit():super(<Favorites>[]);
  var favDaoRepository = FavoritesDaoRepository();

  Future<void> loadFavorites() async {
    final list = await favDaoRepository.loadFavorites();
    emit(list);
  }

  Future<void> addToFavorites(String ad, String resim,String kategori,int fiyat, String marka) async {
    await favDaoRepository.save(ad, resim, kategori, fiyat, marka);
    await loadFavorites(); // veritabanı değişince güncelle
  }

  Future<void> removeFromFavorites(int id) async {
    await favDaoRepository.delete(id);
    await loadFavorites();
  }

  Future<bool> isFavorite(String ad) async {
    return await favDaoRepository.isFavorite(ad);
  }
  
}