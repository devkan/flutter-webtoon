import 'package:app/screens/home_screen.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

void main() {
  // getTodaysToons 유닛 테스트
  //ApiService().getTodaysToons(); // static으로 되지 전
  //ApiService.getTodaysToons(); // static으로 지정된 후

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  // 위젯은 아이디처럼 고유 key가 있다.

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 여기도 const 제거
      home: HomeScreen(),
      // The constructor being called isn't a const constructor.
      // home_screen에 Future 타입이 들어오면서 MaterialApp() const 제거
    );
  }
}
