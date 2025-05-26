import 'package:e_ticaret_app/ui/screens/fav_screen.dart';
import 'package:e_ticaret_app/ui/screens/main_screen.dart';
import 'package:e_ticaret_app/ui/screens/profile_screen.dart';
import 'package:e_ticaret_app/ui/tools/app_color.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _currentIndex = 0;
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _selectTab(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState!.popUntil((r) => r.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index, Widget screen) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => screen),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 👈 EKRANI OLUŞTURAN YAPI
      body: Stack(
        children: [
          _buildOffstageNavigator(0, const MainScreen()),
          _buildOffstageNavigator(1, FavoritesScreen()),
          _buildOffstageNavigator(2, ProfileScreen()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: textColor1,
        onTap: _selectTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Anasayfa"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoriler",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
