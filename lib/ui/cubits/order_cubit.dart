import 'package:e_ticaret_app/data/entity/orderedItems.dart';
import 'package:e_ticaret_app/data/repo/app_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<List<Ordereditems>> {
  OrderCubit():super(<Ordereditems>[]);
  var appDaoRepository = AppDaoRepository();

  Future<void> loadOrder(String kullaniciAdi) async {
    var list = await appDaoRepository.loadOrder(kullaniciAdi);
    emit(list);
  }

  Future<void> delete(int sepetId, String kullaniciAdi) async {
    await appDaoRepository.delete(kullaniciAdi, sepetId);
  }

  Future<void> ordered (String ad,String resim,String kategori,int fiyat,String marka,int siparisAdeti,String kullaniciAdi) async{
    await appDaoRepository.ordered(ad, resim, kategori, fiyat, marka, siparisAdeti,kullaniciAdi);
  }
  
}