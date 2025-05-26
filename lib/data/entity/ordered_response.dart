import 'package:e_ticaret_app/data/entity/orderedItems.dart';

class OrderedResponse {
  List<Ordereditems> orderedItems;
  int success;

  OrderedResponse({
    required this.orderedItems,
    required this.success,
  });

    factory OrderedResponse.fromJson(Map<String,dynamic> json){
    var success =json["success"] as int;
    var jsonArray = json["urunler_sepeti"] as List<dynamic>? ?? [];

    var ordered = jsonArray.map((jsonObject) => Ordereditems.fromJson(jsonObject)).toList();
    return OrderedResponse(success: success, orderedItems: ordered);
  }

}