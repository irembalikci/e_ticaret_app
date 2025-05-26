import 'package:e_ticaret_app/data/entity/orderedItems.dart';
import 'package:e_ticaret_app/ui/components/my_app_bar.dart';
import 'package:e_ticaret_app/ui/cubits/order_cubit.dart';
import 'package:e_ticaret_app/ui/tools/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    String kullaniciAdi = "irembalikci";
    context.read<OrderCubit>().loadOrder(kullaniciAdi);
  }

  @override
  Widget build(BuildContext context) {
    String image = "http://kasimadalan.pe.hu/urunler/resimler";
    return Scaffold(
      appBar: MyAppBar(title: "Sepetim"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 100,
            ), // Alt kısmı buton için boş bırakıyor
            child: BlocBuilder<OrderCubit, List<Ordereditems>>(
              builder: (context, orderedList) {
                Map<String, List<Ordereditems>> grouped = {};
                for (var item in orderedList) {
                  grouped.putIfAbsent(item.ad, () => []).add(item);
                }
                List<MapEntry<String, List<Ordereditems>>> groupedEntries =
                    grouped.entries.toList();

                if (orderedList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: groupedEntries.length,
                    itemBuilder: (context, index) {
                      var urunAdi = groupedEntries[index].key;
                      var urunListesi = groupedEntries[index].value;
                      var orderedItem = urunListesi.first;
                      int adet = urunListesi.fold(
                        0,
                        (sum, item) => sum + item.siparisAdeti,
                      );

                      return Card(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "$image/${urunAdi.toLowerCase().replaceAll('ç', 'c').replaceAll('ğ', 'g').replaceAll('ı', 'i').replaceAll('ö', 'o').replaceAll('ş', 's').replaceAll('ü', 'u')}.png",
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Text(urunAdi, style: TextStyle(fontSize: 20)),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Fiyat: ${orderedItem.fiyat} ₺"),
                                  Text("Adet: $adet"),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final cubit = context.read<OrderCubit>();
                                    final kullaniciAdi =
                                        orderedItem.kullaniciAdi;

                                    if (orderedItem.siparisAdeti > 1) {
                                      await cubit.delete(
                                        orderedItem.sepetId,
                                        kullaniciAdi,
                                      );
                                      for (
                                        int i = 0;
                                        i < orderedItem.siparisAdeti - 1;
                                        i++
                                      ) {
                                        await cubit.ordered(
                                          orderedItem.ad,
                                          orderedItem.resim,
                                          orderedItem.kategori,
                                          orderedItem.fiyat,
                                          orderedItem.marka,
                                          1,
                                          kullaniciAdi,
                                        );
                                      }
                                    } else {
                                      await cubit.delete(
                                        orderedItem.sepetId,
                                        kullaniciAdi,
                                      );
                                    }

                                    await cubit.loadOrder(kullaniciAdi);
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: textColor1,
                                  ),
                                ),
                                Text("${adet * orderedItem.fiyat} ₺"),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Henüz sepete ürün eklenmedi."),
                  );
                }
              },
            ),
          ),
          // ALT SABİT BUTON + TOPLAM FİYAT
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: BlocBuilder<OrderCubit, List<Ordereditems>>(
                builder: (context, orderedList) {
                  int toplam = orderedList.fold(
                    0,
                    (sum, item) => sum + (item.fiyat * item.siparisAdeti),
                  );
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Toplam: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$toplam ₺",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Sepeti onayla işlemleri
                          },
                          child: Text(
                            "Sepeti Onayla",
                            style: TextStyle(color: textColor1, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
