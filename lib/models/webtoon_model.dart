class WebtoonModel {
  final String title, thumb, id;

  // named constructor
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];

  // json으로 넘어오는 값은 
  // {id: 819717, title: xxxxx, thumb: https://xxxx.jpg} 이런형태다.
  // js의 json 형태랑 틀린것이 dart에서 이미 한번 가공이 된거 같다.


  /*
  late final String title, thumb, id;
  WebtoonModel(Map<String, dynamic> json){
    title = json['title'];
    thumb = json['thumb'];
    id = json['id'];
  }
  이렇게 사용해도 된다.. 하지만 이게 잘 안 쓰는 패턴이고, 위 형태로 더 많이 쓰인다.
  위는 constructor에 인수만 적어주고, property를 적어주면 초기화 할수 있어서 매우 편한다.
  그래서 named constructor로 프로퍼티 전체를 초기화 하는경우 late 가 필요하지 않다.
  왜냐면 constructor를 실행한 시점에서 전체 property가 이미 초기화를 완료하기 때문이다.
  중요한 것은 인스턴스 생성시 property가 반드시 초기화 되어야 한다는 것이다.
  */

}
