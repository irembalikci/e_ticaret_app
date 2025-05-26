import 'package:e_ticaret_app/ui/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> fakeNotifications = [
    {
      "title": "Siparişiniz Kargoya Verildi!",
      "message":
          "Kemer siparişiniz kargoya teslim edildi. Tahmini teslimat: 28 Mayıs.",
      "timestamp": "2 saat önce",
      "icon": Icons.local_shipping,
    },
    {
      "title": "Kampanya Fırsatı!",
      "message": "Sadece bugün tüm çantalar %30 indirimli!",
      "timestamp": "5 saat önce",
      "icon": Icons.discount,
    },
    {
      "title": "Ödemeniz Başarıyla Alındı",
      "message": "Siparişiniz için 4.400 ₺ ödemeniz başarıyla alındı.",
      "timestamp": "1 gün önce",
      "icon": Icons.check_circle_outline,
    },
    {
      "title": "Yeni Ürün: Lüks Cüzdan",
      "message": "Dior koleksiyonuna yeni bir cüzdan eklendi. Şimdi keşfet!",
      "timestamp": "2 gün önce",
      "icon": Icons.new_releases,
    },
    {
      "title": "Sepetiniz Sizi Bekliyor",
      "message":
          "Sepetinizde bıraktığınız ürünler hâlâ sizi bekliyor. Şimdi tamamlayın.",
      "timestamp": "3 gün önce",
      "icon": Icons.shopping_cart_outlined,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Bildirimler"),
      body: ListView.builder(
        itemCount: fakeNotifications.length,
        itemBuilder: (context, index) {
          var notification = fakeNotifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(notification['icon'], color: Colors.blue),
              title: Text(
                notification['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['message']),
                  const SizedBox(height: 4),
                  Text(
                    notification['timestamp'],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
