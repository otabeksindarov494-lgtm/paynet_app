import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paynet_app/history/history_page.dart';
import 'package:paynet_app/history/history_storage.dart';
import 'package:paynet_app/widgets/navigation_page.dart';
import '../color/colors.dart';
import '../widgets/true_request_button.dart';

class SuccessNoPage extends StatelessWidget {
  final String amount;
  final String name;
  final String requestId;
  final String phone;
  final File? image;
  final Map<String, String> card;

  const SuccessNoPage({
    super.key,
    required this.amount,
    required this.name,
    required this.requestId,
    required this.phone,
    required this.image,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff055a41), Color(0xff000000), Color(0xff000000)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 144),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/img_20.png',
                    width: 120,
                    height: 120,
                  ),
                ),

                SizedBox(height: 30),
                Text(
                  'Запрос отменен',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'bold',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Запрос на $amount сум к пользователя $name успешно отменен',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular',
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [trueColor, trueColor2],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Вернуться на главную',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: TrueRequestButton(
                          label: 'Посмотреть историю',
                          height: 56,
                          borderRadius: 30,
                          onPressed: () {
                            cancelRequest(requestId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HistoryPage(
                                  amount: amount,
                                  name: name,
                                  phone: phone,
                                  image: image,
                                  card: card,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
