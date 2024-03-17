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
}
