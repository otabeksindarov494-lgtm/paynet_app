import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_glow_border/gradient_glow_border.dart';
import 'package:paynet_app/color/colors.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listSend = [
      {'icon': Icons.home, 'title': 'Kommunal tolovlar'},
      {'icon': Icons.leaderboard_rounded, 'title': 'Mobil operatorlar'},
      {'icon': Icons.account_balance, 'title': 'Davlat xizmatlari'},
      {'icon': Icons.wifi, 'title': 'Internet provayderlar'},
      {'icon': Icons.phone_android_rounded, 'title': 'Telefon'},
      {
        'icon': Icons.signal_cellular_connected_no_internet_4_bar,
        'title': 'Internet xizmatlar',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff055a41), Color(0xff000000), Color(0xff000000)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Оплата',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 380,
                  height: 50,
                  child: GradientGlowBorder.solid(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    blurRadius: 1,
                    colors: [Colors.blue, Colors.red],
                    animate: true,
                    animationCurve: Curves.linear,
                    animationDuration: Duration(seconds: 2),
                    glowOpacity: 1,
                    spreadRadius: 0,
                    thickness: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [primaryColor, trueColor],
                          ),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Поиск',
                          hintStyle: TextStyle(color: Colors.white54),
                          icon: Icon(Icons.search, color: Colors.white54),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: listSend.length,
                    itemBuilder: (context, index) {
                      final list = listSend[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              list['icon'] as IconData,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list['title'] as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
