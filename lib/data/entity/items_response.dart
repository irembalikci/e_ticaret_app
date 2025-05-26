import 'package:e_ticaret_app/data/entity/items.dart';

class ItemsResponse {
  List<Items> items;
  int success;

  ItemsResponse({
    required this.items,
    required this.success,
  });

  factory ItemsResponse.fromJson(Map<String,dynamic> json){
    var success =json["success"] as int;
    var jsonArray = json["urunler"] as List;

    var items = jsonArray.map((jsonObject) => Items.fromJson(jsonObject)).toList();
    return ItemsResponse(items: items, success: success);
  }
}