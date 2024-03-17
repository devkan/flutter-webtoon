import 'package:app/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector 동작을 감지하는 위젯이다.
    return GestureDetector(
      // onTap은 탭을 했을때 이벤트가 발생하는 함수로, onTapUp(손가락을 올렸을때), onTapDown(손가락으로 내렸을때)를 포함하는 함수다.
      onTap: () {
        //print("home");
        // Navigator로 새 route를 push하고, route는 MaterialPageRoute로 만들어서,
        // 그 route는 StatelessWidget뿐인 DetailScreen을 랜더하게 되는 것이다.
        // Navigator.push의 route로 StatelessWidget은 바로 올수 없다.
        Navigator.push(
          context,
          /*
          // bottom에서 올라오는 효과를 내지 못해서 PageRouteBuilder로 교체함
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
            fullscreenDialog: true,
          ),
          */
          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, anmation, secondaryAnimation) =>
                DetailScreen(id: id, title: title, thumb: thumb),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(10, 10),
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),

            // Image.network는 외부 이미지를 불러오는 메소드로 보면 된다.
            // Referer를 추가하지 않으면 naver정책에 의해 이미지를 가져오지 못한다.
            // HTTP request failed, statusCode: 403 오류가 발생한다.
            child: Image.network(thumb, headers: const {
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
              'Referer': 'https://comic.naver.com',
            }),
          ),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                fontSize: 22,
              )),
        ],
      ),
    );
  }
}
