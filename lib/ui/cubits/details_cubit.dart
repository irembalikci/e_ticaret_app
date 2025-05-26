import 'package:e_ticaret_app/data/repo/app_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<void> {
  DetailsCubit():super(0);
  var appDaoRepository = AppDaoRepository();

  Future<void> ordered (String ad,String resim,String kategori,int fiyat,String marka,int siparisAdeti,String kullaniciAdi) async{
    await appDaoRepository.ordered(ad, resim, kategori, fiyat, marka, siparisAdeti,kullaniciAdi);
  }
}