import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbdemo/model/banner_model.dart';
import 'package:fbdemo/model/tbl_model.dart';
import 'package:http/http.dart';

import '../model/user_model.dart';

class UserRepository {
  // String userUrl = 'https://reqres.in/api/users?page=2';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<BannerModel>> getUsers() async {
    Completer<List<BannerModel>> completer = Completer<List<BannerModel>>();
    List<BannerModel> bannerList = [];

    StreamSubscription<QuerySnapshot> subscription = firestore.collection('tblBanner').snapshots().listen((event) {
      bannerList.clear();
      for (var element in event.docs) {
        BannerModel model = BannerModel.fromJson(element.data());
        if (model.isDeleted == "false") bannerList.add(model);
      }
      completer.complete(bannerList);
    });

    await completer.future;
    subscription.cancel();

    return bannerList;
  }

  Future<List<TblModel>> getTableData() async {
    Completer<List<TblModel>> completer = Completer<List<TblModel>>();
    List<TblModel> list = [];

    StreamSubscription<QuerySnapshot> subscription = firestore.collection('05e340eb5098bd90').snapshots().listen((event) {
      list.clear();
      for (var element in event.docs) {
        TblModel model = TblModel.fromJson(element.data());
        list.add(model);
      }
      completer.complete(list);
    });

    await completer.future;
    subscription.cancel(); // Cancel the stream subscription

    return list;
  }
}
