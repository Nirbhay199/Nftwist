import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nftwist/constant/app_content_modal.dart';
import 'package:nftwist/model/all_collection.dart';
import 'package:nftwist/services/api_response_handler.dart';

class AppContents with ChangeNotifier {
  AppTERMS? appTERMS;
  AppPrivacy? appPrivacy;
  List<Faq> faqs = [];
  Collections? _collections;
  Collections? get collections =>_collections;
  getAppData(type) async {
    var result = await ApiResponse().getStaticData(type);
    result = await jsonDecode(result.body);
     if (result[0]['type'] == type) {
      // print("${result[0]['name']}------");
      appTERMS = AppTERMS(
          name: result[0]['name'],
          id: result[0]['_id'],
          text: result[0]['text'],
          type: result[0]['type'],
          createdAt: result[0]['createdAt'],
          link: result[0]['link'],
          updatedAt: result[0]['updatedAt'],
          v: result[0]['__v']);
    }
    if (result[0]['type'] == type) {
      appPrivacy = AppPrivacy(
        name: result[0]['name'],
        id: result[0]['_id'],
        text: result[0]['text'],
        type: result[0]['type'],
        createdAt: result[0]['createdAt'],
        link: result[0]['link'],
        updatedAt: result[0]['updatedAt'],
        v: result[0]['__v'],
      );
    }
    notifyListeners();
  }

  getFaq() async {
    var result = await ApiResponse().getfaq();
    result = await jsonDecode(result.body);
    // print(result['faqs']);
    result['faqs'].forEach((faq) {
      // print("lldkflkdl---${faq['_id']}");
      faqs.add(Faq(
        id: faq['_id'],
        created_at: faq['created_at'],
        answer: faq['answer'],
        question: faq['question'],
      ));
      print(faqs.length);
    });
    notifyListeners();
  }
  
  allCollection()async{
    var result=await jsonDecode((await  ApiResponse().allCollection()).body);
    _collections=Collections.fromJson(result);
    notifyListeners();
  }
  
}
