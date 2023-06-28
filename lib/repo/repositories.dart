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
          print("-=-=-=-=>"+element.data().toString());
          BannerModel model = BannerModel.fromJson(element.data());
          if (model.isDeleted == "false") bannerList.add(model);
        }
        if (!completer.isCompleted) {
          completer.complete(bannerList);
        }
      });

      await completer.future;
      // subscription.cancel();

      return bannerList;
    }

  Future<List<TblModel>> getTableData() async {
    Completer<List<TblModel>> completer = Completer<List<TblModel>>();
    List<TblModel> list = [];
    // String userID= '05e340eb5098bd90';
    String userID= 'category1';
    // String userID= 'a331fd667f04ce99';

    StreamSubscription<QuerySnapshot> subscription = firestore.collection(userID).snapshots().listen((event) {
      list.clear();
      for (var element in event.docs) {
        TblModel model = TblModel.fromJson(element.data());
        list.add(model);
      }
      if (!completer.isCompleted) {
        completer.complete(list);
      }
    });

    await completer.future;
    // subscription.cancel(); // Cancel the stream subscription

    return list;
  }

  /*Future<List<TblModel>> getTableData(int limit,  List<TblModel> lastDocument) async {
    List<TblModel> list = [];

    Query query = firestore.collection('05e340eb5098bd90').orderBy('date_time').limit(limit);

    if (lastDocument.isNotEmpty) {
      query = firestore.collection('05e340eb5098bd90')
          .orderBy('date_time')
          .startAfter([lastDocument.last.date_time]) // Assuming 'date_time' is the field you are ordering by
          .limit(limit);
    }

    QuerySnapshot querySnapshot = await query.get();

    list.addAll(lastDocument);
    for (var element in querySnapshot.docs) {
      print("-=-=-=-=>"+element.data().toString());
      Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
      if (data != null) {
        TblModel model = TblModel.fromJson(data);
        list.add(model);
      }
    }


    return list;
  }*/



}
