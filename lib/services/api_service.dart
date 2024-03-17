import 'dart:convert';

import 'package:app/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev/";
  static const String today = "today";
  /*
  baseUrl, today는 final을 사용하다가, static const로 변경되었다. 밑의 getTodaysToons()는 static만 추가하고..
  이는 해당 변수나 함수를 인스턴스화 없이 직접 클래스명을 통해 접근할 수 있게 해 주기 위함이다.
  다시 말해 종속적인 객체를 만들면, 매번 호출시 객체로 만들어야 하는데, static으로 지정하면 객체를 생성하지 않고 바로 사용이 가능하다.
  이것은 인스턴스의 상태를 유지할 필요가 없는 상수나 유틸리티 함수를 제공할 때 유용하다.
  */

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstance = [];
    final url = Uri.parse('$baseUrl$today');

    //get(baseUrl);
    // 너무 일반적으로 함수명을 가지고 있어서 import에다 "as httpd"를 추가해 별칭을 주었다.
    // 그럼 이제는 그냥 get()으로 호출하면 안되고, 아래처럼 http.get()으로 호출해야 한다.

    final response = await http.get(url);
    // get에는 Uri타입의 Url이 필요하다. 그래서 위애서 Uri.parse()를 이용해 Uri타입으로 만든뒤 url이 할당했다.
    // 결과값을 받는데, 서버 상태에 따른 대기나 시간이 소요된다. 그래서 비동기식으로 처리해야 한다.
    // 그래서 async 함수로 만들고, await로 결과값이 나올때까지 대기를 걸어 두었다.
    // 그리고 return 타입이 Future 타입의 Response이다. "Future<Response>" Future타입은 비동기식으로 봐도 될듯

    if (response.statusCode == 200) {
      //print(response.body);
      final List<dynamic> webtoons = jsonDecode(response.body);
      // final webtoons = jsonDecode(response.body);
      // 이렇게 사용해도 문제없다.
      // jsonDecode으로 반환되는 값들이 dynamic 타입이다. jsonDecode를 보면 된다. 이것을 List형태로 담으려고 하는 것이다.

      for (var webtoon in webtoons) {
        print(webtoon);

        //final toon = WebtoonModel.fromJson(webtoon);
        //print(toon.title);
        // 테스트로 title 찍어볼때..

        webtoonInstance.add(WebtoonModel.fromJson(webtoon));
      }

      return webtoonInstance;
    }
    throw Error();
  }
}
