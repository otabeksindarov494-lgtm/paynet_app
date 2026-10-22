import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../color/colors.dart';
import 'package:paynet_app/widgets/request_money_page.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contactUser = [
      {'name': 'Sindarov Otabek', 'phone': '+998 50 054 47 64'},
      {'name': 'Xolmatov Alisher', 'phone': '+998 50 054 47 64'},
      {'name': 'Sindarova Gozal', 'phone': '+998 50 054 47 64'},
      {'name': 'Ismoilov Abror', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Norchayeva Mamura', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: BoxDecoration(
              color: Color(0xFF16191D),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Контакты',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 17),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(gradient: LinearGradient(colors: [primaryColor, trueColor2])),
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Имя или номер телефона',
                        hintStyle: TextStyle(color: Colors.white54),
                        icon: Icon(Icons.search, color: Colors.white54),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Expanded(
                    child: ListView.separated(
                      itemCount: contactUser.length,
                      itemBuilder: (context, index) {
                        Divider(height: 1, color: Colors.grey.shade700, thickness: 0.5);
                        final contact = contactUser[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RequestMoneyPage(
                                  name: contact['name']!,
                                  phone: contact['phone']!,
                                ),
                              ),
                            );
                          },

                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            padding: EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 24),
                            decoration: BoxDecoration(
                              color: Color(0xFF16191D),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white12,
                                  child: Text(
                                    contact['name']![0],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact['name']!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      contact['phone']!,
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios, color: Colors.white),
                              ],
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: 1, color: Colors.grey, thickness: 0.5,);
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
