// ignore: file_names

class TblModel {
  String? catAuth;
  String? catDesc;
  String? catId;
  String? catImgURL;
  String? catTitle;
  String? isDeleted;
  String? timestamp;

  TblModel({this.catAuth, this.catDesc, this.catId, this.catImgURL, this.catTitle, this.isDeleted, this.timestamp});

  TblModel.fromJson(Map<String, dynamic> json) {
    catAuth = json['catAuth'].toString();
    catDesc = json['catDesc'].toString();
    catId = json['catId'].toString();
    catImgURL = json['catImgURL'].toString();
    catTitle = json['catTitle'].toString();
    isDeleted = json['isDeleted'].toString();
    timestamp = json['timestamp'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['catAuth'] = catAuth;
    data['catDesc'] = catDesc;
    data['catId'] = catId;
    data['catImgURL'] = catImgURL;
    data['catTitle'] = catTitle;
    data['isDeleted'] = isDeleted;
    data['timestamp'] = timestamp;
    return data;
  }
}

// catAuth
// catDesc
// catId
// catImgURL
// catTitle
// isDeleted
// timestamp