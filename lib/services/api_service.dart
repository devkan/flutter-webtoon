import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev/";
  final String today = "today";

  void getTodaysToons() async {
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
      print(response.body);

      return;
    }
    throw Error();
  }
}
