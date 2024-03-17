import 'package:app/models/webtoon_model.dart';
import 'package:app/services/api_service.dart';
import 'package:app/widget/webtoon_widget.dart';
import 'package:flutter/material.dart';

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
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),

                // Expanded를 사용하지 않고, makeList(snapshot)를 사용하면
                // Horizontal viewport was given unbounded height. 이런 에러를 발생시킨다.
                // 이는 Column이 makeList()로 생성되는 ListView의 높이를 알수가 없기 때문이다.
                // Expanded는 Row나 Column의 child를 확장해서 그 child가 남긴 공간을 채우기 때문에 사용한다.
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      // ListView는 최적화되지 않은 것이라서 이것보다는 ListView.builder를 더 많이 사용한다.
      // ListView.builder는 사용자가 보고 있는 아이템만 빌드하고, 안보면 메모리에서 제거한다.
      // 그래서 item을 빌드할때마다 itemBuilder를 호출해서 사용한다.

      scrollDirection: Axis.horizontal, // 수평 스크롤
      itemCount: snapshot.data!.length, // 아이템 갯수
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // data!가 아니면 오류가 발생한다. data가 null일수도 있다고 dart가 알려주는 것이다.
      // 하지만 hasData의 if문으로 이곳의 data는 null일 수가 없다. 그러니 !로 확실하는 것을 알려주는 것이다.

      itemBuilder: (context, index) {
        //print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
