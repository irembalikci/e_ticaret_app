import 'package:e_ticaret_app/data/entity/items.dart';
import 'package:e_ticaret_app/data/entity/main_state.dart';
import 'package:e_ticaret_app/data/repo/app_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit():super(MainState(items: [], orderedItems: []));
  var appDaoRepository = AppDaoRepository();
  List<Items> allItems = [];
  
  Future<void> loadItems () async{
    var list = await appDaoRepository.loadItems();
    emit(state.coppyWith(items: list));
  }

  Future<void> search (String searchText) async {
    var items = await appDaoRepository.loadItems();
    allItems = items;
    final filtered = allItems.where((item) =>
      item.ad.toLowerCase().contains(searchText.toLowerCase())).toList();
    emit(state.coppyWith(items: filtered));
  }
}