import 'package:e_ticaret_app/ui/components/my_app_bar.dart';
import 'package:e_ticaret_app/ui/tools/app_color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "İrem Balıkcı";
  final String email = "irembalikci@example.com";
  final String phone = "+90 532 123 45 67";
  final String profileImage = "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=300&q=80";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Profil"),
      body: Column(
        children: [
          const SizedBox(height: 24),
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(profileImage)),
          const SizedBox(height: 12),
          Text(
            userName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(email),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildProfileCard(
                  icon: Icons.phone,
                  title: "Telefon",
                  subtitle: phone,
                ),
                _buildProfileCard(
                  icon: Icons.home,
                  title: "Adres",
                  subtitle: "Ataköy Mah. No:23 Bakırköy / İstanbul",
                ),
                _buildProfileCard(
                  icon: Icons.shopping_bag,
                  title: "Siparişlerim",
                  subtitle: "Son sipariş: Kemer - 4400 ₺",
                ),
                _buildProfileCard(
                  icon: Icons.favorite,
                  title: "Favorilerim",
                  subtitle: "3 ürün favorilere eklendi",
                ),
                _buildProfileCard(
                  icon: Icons.settings,
                  title: "Ayarlar",
                  subtitle: "Bildirim, güvenlik ve dil",
                ),
                _buildProfileCard(
                  icon: Icons.logout,
                  title: "Çıkış Yap",
                  subtitle: "Hesabınızdan çıkış yapın",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: mainColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // navigasyon eklenebilir
        },
      ),
    );
  }
}
