import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,

        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        // 안드로이드에서는 elevation만 줘서는 에뮬에서 새도우가 제대로 생성이 안되었다.
        // 그래서 surfaceTintColor, shadowColor를 추가해서 구성했다.
        // 아이폰 에뮬에서는 elevation만 주어도 그림자가 들어가는거 같다.

        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "Today's WebToon",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
