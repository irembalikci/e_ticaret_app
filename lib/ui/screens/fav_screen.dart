import 'package:e_ticaret_app/data/entity/favorites.dart';
import 'package:e_ticaret_app/ui/components/my_app_bar.dart';
import 'package:e_ticaret_app/ui/cubits/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    String image = "http://kasimadalan.pe.hu/urunler/resimler";
    return Scaffold(
      appBar: MyAppBar(title: "Favorilerim"),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<FavCubit, List<Favorites>>(
              builder: (context, favoritesList) {
                if (favoritesList.isNotEmpty) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                          ),
                      itemCount: favoritesList.length,
                      itemBuilder: (context, index) {
                        var favorites = favoritesList[index];
                        // orderedList'ten sadece bu item'a ait olanları filtrele
                        // Yeni Ordereditems nesnesi oluşturuluyor

                        return Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  "$image/${favorites.ad.toLowerCase().replaceAll('ç', 'c').replaceAll('ğ', 'g').replaceAll('ı', 'i').replaceAll('ö', 'o').replaceAll('ş', 's').replaceAll('ü', 'u')}.png",
                                ),
                              ),
                              Text(
                                favorites.ad,
                                style: TextStyle(fontSize: 20),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${favorites.fiyat.toString()} ₺",
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<FavCubit>()
                                          .removeFromFavorites(favorites.id);
                                      context.read<FavCubit>().loadFavorites();
                                    },
                                    icon: Icon(Icons.remove_circle_rounded),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Henüz favori ürününüz bulunmuyor."),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
