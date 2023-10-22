// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
//
// import '../model/partnersNfts-model.dart';
// import '../services/api_response_handler.dart';
//
// class PartnerNFt with ChangeNotifier {
//   final List<PartnerNftsModel> _partnerNFTs = [];
//   List<PartnerNftsModel> get partnerNFTs {
//     return _partnerNFTs;
//   }
//
//   getList(data){
//     data.forEach((ele) {
//       if (_partnerNFTs.any((element) => element.sId == ele['id'])) {
//         int? index =
//         _partnerNFTs.indexWhere((element) => element.sId == ele['id']);
//         _partnerNFTs[index] = PartnerNftsModel.fromJson(ele);
//       } else {
//         _partnerNFTs.add(PartnerNftsModel.fromJson(ele));
//       }
//     });
//   }
//   getPartnerNFTs() async {
//     var response = await ApiResponse().getPartnersNfts();
//     var data = await jsonDecode(response.body);
//     data["response"]["data"].forEach((ele) {
//       if (_partnerNFTs.any((element) => element.sId == ele['id'])) {
//         int? index =
//         _partnerNFTs.indexWhere((element) => element.sId == ele['id']);
//         _partnerNFTs[index] = PartnerNftsModel.fromJson(ele);
//       } else {
//         _partnerNFTs.add(PartnerNftsModel.fromJson(ele));
//       }
//     });
//     notifyListeners();
//   }
//   like(context){
//
//   }
// }