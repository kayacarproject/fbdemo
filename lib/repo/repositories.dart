import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbdemo/model/banner_model.dart';
import 'package:http/http.dart';

import '../model/user_model.dart';

class UserRepository {
  String userUrl = 'https://reqres.in/api/users?page=2';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<BannerModel>> getUsers() async {
    List<BannerModel> bannerList = [];
    await firestore.collection('tblBanner').snapshots().listen((event) {
      // print("=-=->${event.docs.length}");

      for (var element in event.docs) {
        BannerModel model = BannerModel.fromJson(element.data());
        // print("model.imgUrl=-=->${model.imgUrl}");
        // setState(() {
        if (model.isDeleted == "false") bannerList.add(model);
        // });
      }
    });
    print(" List<BannerModel> bannerList=[]-=-=-->"+bannerList.length.toString());
    return bannerList;
    /* Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }*/
  }
}
