import 'package:e_ticaret_app/data/entity/main_state.dart';
import 'package:e_ticaret_app/data/entity/orderedItems.dart';
import 'package:e_ticaret_app/ui/components/my_app_bar.dart';
import 'package:e_ticaret_app/ui/cubits/main_cubit.dart';
import 'package:e_ticaret_app/ui/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    String image = "http://kasimadalan.pe.hu/urunler/resimler";
    return Scaffold(
      appBar: MyAppBar(title: "Shopping"),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                placeholder: "Ara",
                onChanged: (searchText) {
                  if (searchText.isEmpty) {
                    context.read<MainCubit>().loadItems();
                  } else {
                    context.read<MainCubit>().search(searchText);
                  }
                },
              ),
            ),
            BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                var itemList = state.items;
                if (itemList.isNotEmpty) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                          ),
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        var items = itemList[index];
                        var orderedItems = Ordereditems(
                          sepetId: 0,
                          ad: items.ad,
                          resim: items.resim,
                          kategori: items.kategori,
                          fiyat: items.fiyat,
                          marka: items.marka,
                          kullaniciAdi: "irembalikci", // sabit değer
                          siparisAdeti: 0, // başlangıç değeri
                        );
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  items: items,
                                  ordereditems: orderedItems,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    "$image/${items.ad.toLowerCase().replaceAll('ç', 'c').replaceAll('ğ', 'g').replaceAll('ı', 'i').replaceAll('ö', 'o').replaceAll('ş', 's').replaceAll('ü', 'u')}.png",
                                  ),
                                ),
                                Text(items.ad, style: TextStyle(fontSize: 20)),
                                const Spacer(),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${items.fiyat.toString()} ₺",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("Bu ürün bulunamadı."));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
