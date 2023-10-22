import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../model/partnersNfts-model.dart';
import '../model/partners_model.dart';
import '../services/api_response_handler.dart';

class Search with ChangeNotifier{

  List<PartnerNftsModel> _partnerNFTs = [];
  List<PartnerNftsModel> get partnerNFTs {
    return _partnerNFTs;
  }
  List<OurPartnersModel> _partners = [];
  List<OurPartnersModel> get partners {
    return _partners;
  }

  getHomeScreenDate({string}) async {
    if(string.trim()==''){
      print("---------------------Clear------------------");
      _partnerNFTs=[];
      _partners=[];
    }else{
      var response = await ApiResponse().getSearch(string: string);
      var data = (await jsonDecode(response.body));
      _partnerNFTs=[];
      _partners=[];
      data['partners'].forEach((ele) {
        if (_partners.any((element) => element.sId == ele['id'])) {
          int? index =
          _partners.indexWhere((element) => element.sId == ele['id']);
          _partners[index] = OurPartnersModel.fromJson(ele);
        } else {
          _partners.add(OurPartnersModel.fromJson(ele));
        }
      });
      data['nfts'].forEach((ele) {
        if (_partnerNFTs.any((element) => element.sId == ele['id'])) {
          int? index =
          _partnerNFTs.indexWhere((element) => element.sId == ele['id']);
          _partnerNFTs[index] = PartnerNftsModel.fromJson(ele);
        } else {
          _partnerNFTs.add(PartnerNftsModel.fromJson(ele));
        }
      });
    }
    notifyListeners();
  }

  clearData(){
    _partnerNFTs=[];
    _partners=[];
    notifyListeners();
  }

}