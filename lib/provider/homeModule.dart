import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nftwist/model/partners_model.dart';
import 'package:nftwist/provider/market_place_nfts.dart';
import 'package:nftwist/provider/partner_nft.dart';
import 'package:nftwist/services/api_response_handler.dart';
import 'package:provider/provider.dart';
import '../constant/toaster.dart';
import '../model/partnersNfts-model.dart';
import '../services/locator.dart';

class HomeModuleProvider with ChangeNotifier {
  final List<OurPartnersModel> _partners = [];
  List<OurPartnersModel> get partners {
    return _partners;
  }



  getHomeScreenDate(context) async {
    var response = await ApiResponse().getHomeScreenData();
    var data = (await jsonDecode(response.body));
    if(response.statusCode==200){
      data["partners"]['partners'].forEach((ele) {
        if (_partners.any((element) => element.sId == ele['_id'])) {
          int? index =
          _partners.indexWhere((element) => element.sId == ele['_id']);
          _partners[index] = OurPartnersModel.fromJson(ele);
        } else {
          _partners.add(OurPartnersModel.fromJson(ele));
        }
      });
      Provider.of<Nfts>(context,listen: false).getPartnerList(data["partnersNfts"]['data']);
      Provider.of<Nfts>(context,listen: false).getList(data['marketPlaceNft']);
    }else{
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    notifyListeners();
  }

  getOurPartners() async {
    var response = await ApiResponse().getOurPartnersList();
    var data = await jsonDecode(response.body);
    data["partners"].forEach((ele) {
      if (_partners.any((element) => element.sId == ele['id'])) {
        int? index =
            _partners.indexWhere((element) => element.sId == ele['id']);
        _partners[index] = OurPartnersModel.fromJson(ele);
      } else {
        _partners.add(OurPartnersModel.fromJson(ele));
      }
    });
    notifyListeners();
  }

}
