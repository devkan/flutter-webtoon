import 'package:app/models/webtoon_model.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

// json 데이타를 받기 위해서 stateless에서 stateful로 변경
class HomeScreenStateful extends StatefulWidget {
  const HomeScreenStateful({super.key});

  @override
  State<HomeScreenStateful> createState() => _HomeScreenStatefulState();
}

class _HomeScreenStatefulState extends State<HomeScreenStateful> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }

  void waitForWebToons() async {
    webtoons = await ApiService.getTodaysToons();
    // await 미사용시 A value of type 'Future<List<WebtoonModel>>' can't be assigned to a variable of type 'List<WebtoonModel>' 이런 오류 남..
    // getTodaysToons는 Future<List<WebtoonModel>>타입을 보내는데, await로 대기후 Future타입이 없어진다고 보면 될거 같다.
    // 그후 List<WebtoonModel>로 받을수 있는 것이다.
    isLoading = false;

    setState(() {});
    // statefulWidget의 UI를 새로고침하기 위해서 호출함
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);

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
