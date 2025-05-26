import 'package:e_ticaret_app/data/entity/items.dart';
import 'package:e_ticaret_app/data/entity/orderedItems.dart';

class MainState {
  final List<Items> items;
  final List<Ordereditems> orderedItems;

  MainState({required this.items,required this.orderedItems});

  MainState coppyWith({List<Items>? items, List<Ordereditems>? orderedItems}){
    return MainState(items: items?? this.items, orderedItems: orderedItems?? this.orderedItems);
  }
}