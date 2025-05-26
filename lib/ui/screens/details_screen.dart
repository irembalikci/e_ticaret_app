import 'package:e_ticaret_app/data/entity/items.dart';
import 'package:e_ticaret_app/data/entity/orderedItems.dart';
import 'package:e_ticaret_app/ui/components/my_app_bar.dart';
import 'package:e_ticaret_app/ui/cubits/details_cubit.dart';
import 'package:e_ticaret_app/ui/cubits/fav_cubit.dart';
import 'package:e_ticaret_app/ui/cubits/order_cubit.dart';
import 'package:e_ticaret_app/ui/screens/order_screen.dart';
import 'package:e_ticaret_app/ui/tools/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  Ordereditems ordereditems;
  Items items;
  DetailsScreen({required this.items, required this.ordereditems});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int count = 0;
  late int unitPrice;
  int totalPrice = 0;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    unitPrice = widget.items.fiyat;
    totalPrice = unitPrice * count;
    // Favori kontrolü
    context.read<FavCubit>().isFavorite(widget.items.ad).then((value) {
      setState(() {
        isFav = value;
      });
    });
  }

  void updateTotalPrice() {
    setState(() {
      totalPrice = unitPrice * count;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    String image = "http://kasimadalan.pe.hu/urunler/resimler";

    return Scaffold(
      appBar: MyAppBar(title: "Ürün Detayı"),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    size: 30,
                    color: isFav ? textColor1 : textColor1,
                  ),
                  onPressed: () async {
                    final item = widget.items;
                    final favCubit = context.read<FavCubit>();

                    bool alreadyFavorited = await favCubit.isFavorite(item.ad);

                    if (alreadyFavorited) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.ad} zaten favorilerde.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      await favCubit.addToFavorites(
                        item.ad,
                        item.resim,
                        item.kategori,
                        item.fiyat,
                        item.marka,
                      );
                      setState(() {
                        isFav = true; // ikon güncellenir
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.ad} favorilere eklendi.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Image.network(
              "$image/${widget.items.ad.toLowerCase().replaceAll('ç', 'c').replaceAll('ğ', 'g').replaceAll('ı', 'i').replaceAll('ö', 'o').replaceAll('ş', 's').replaceAll('ü', 'u')}.png",
            ),
            Text(widget.items.ad, style: TextStyle(fontSize: 20)),
            Text(
              "${widget.items.fiyat.toString()} ₺",
              style: TextStyle(fontSize: 15, color: textColor1),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: textColor2,
                width: screenWidth / 2,
                height: screenHeight / 15,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (count > 0) {
                          setState(() {
                            count--;
                            widget.ordereditems.siparisAdeti = count;
                            updateTotalPrice();
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle_rounded,
                        color: textColor1,
                        size: 35,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      count.toString(),
                      style: TextStyle(fontSize: 30, color: mainColor),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          count++;
                          widget.ordereditems.siparisAdeti = count;
                          updateTotalPrice();
                        });
                      },
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: textColor1,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text("Kategori: ${widget.items.kategori}"),
            Text("Marka: ${widget.items.marka}"),
            const Spacer(),
            if (count >= 1)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      "$totalPrice ₺",
                      style: TextStyle(fontSize: 30, color: textColor1),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: textColor1,
                      ),
                      onPressed: () {
                        context.read<DetailsCubit>().ordered(
                          widget.items.ad,
                          widget.items.resim,
                          widget.items.kategori,
                          widget.items.fiyat,
                          widget.items.marka,
                          widget.ordereditems.siparisAdeti,
                          widget.ordereditems.kullaniciAdi,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(),
                          ),
                        ).then((_) {
                          context.read<OrderCubit>().loadOrder(
                            widget.ordereditems.kullaniciAdi,
                          );
                        });
                      },
                      child: Text(
                        "Sepete Ekle",
                        style: TextStyle(color: textColor2),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
