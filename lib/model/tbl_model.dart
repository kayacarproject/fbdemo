// ignore: file_names

class TblModel {
  String? big_text;
  String? date_time;
  String? sub_text;
  String? title;

  TblModel({this.big_text, this.date_time, this.sub_text, this.title});

  TblModel.fromJson(Map<String, dynamic> json) {
    big_text = json['big_text'].toString();
    date_time = json['date_time'].toString();
    sub_text = json['sub_text'].toString();
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['big_text'] = big_text;
    data['date_time'] = date_time;
    data['sub_text'] = sub_text;
    data['title'] = title;
    return data;
  }
}
