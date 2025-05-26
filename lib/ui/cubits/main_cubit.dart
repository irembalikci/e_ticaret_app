import 'package:e_ticaret_app/data/entity/main_state.dart';
import 'package:e_ticaret_app/data/repo/app_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit():super(MainState(items: [], orderedItems: []));
  var appDaoRepository = AppDaoRepository();
  
  Future<void> loadItems () async{
    var list = await appDaoRepository.loadItems();
    emit(state.coppyWith(items: list));
  }

  Future<void> search (String searchText) async {
    var list = await appDaoRepository.search(searchText);
    emit(state.coppyWith(items: list));
  }
}