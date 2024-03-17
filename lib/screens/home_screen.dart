import 'package:app/models/webtoon_model.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// json 데이타를 받기 위해서 stateless에서 stateful로 변경
// stateful 방식에서 다시 stateless로 변경함
// state는 자주 사용하지 않는게 좋다.
// state는 그렇게 많이 사용하지 않고, state를 전형 안쓰는 좋은 widget과 framework가 많기 때문이다.
// 그래서 다시 stateless로 state를 사용하지 않고 fetch해서 처리하게 구성을 할 것이다.
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}); // const 제거함 아래 Future 데이타로 데이타의 변화가 생기기 때문이다.

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
  // 이코드를 추가하면 const HomeScreen({super.key}); 에 오류가 발생한다.
  // Can't define the 'const' constructor because the field 'webtoons' is initialized with a non-constant value.
  // class에 Future 타입이 들어왔기 때문이다. const는 컴파일전에 값을 알고 있다는 것이다. Future는 차후 런타입에 데이타가 정해진다.
  // 즉, 데이타 변화가 생긴다는 것으로 그래서 클래스가 const를 가질수 없는 것이다.
  // main.dart의 MaterialApp의 const도 제거했다.

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
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text("data");
          } else {
            return const Text("loading...");
          }
        },
      ),
    );
  }
}
