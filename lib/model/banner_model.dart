// ignore: file_names


class BannerModel {
  String? imgUrl;
  String? videoUrl;
  String? isDeleted;
  String? id;
  String? timestamp;

  BannerModel(
      {this.imgUrl, this.videoUrl, this.isDeleted, this.id, this.timestamp});

  BannerModel.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'].toString();
    videoUrl = json['videoUrl'].toString();
    isDeleted = json['isDeleted'].toString();
    id = json['id'].toString();
    timestamp = json['timestamp'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['imgUrl'] = imgUrl;
    data['videoUrl'] = videoUrl;
    data['isDeleted'] = isDeleted;
    data['id'] = id;
    data['timestamp'] = timestamp;
    return data;
  }
}
