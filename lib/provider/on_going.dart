import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nftwist/services/api_response_handler.dart';

class OnGoingCampaigns with ChangeNotifier{

  List<OnGoingCampaign> _onGoingCampaign=[];
  List<OnGoingCampaign> get  onGoingCampaign =>_onGoingCampaign;

  getOnGoingCampaign()async{
    var result=await ApiResponse().onGoingCampaigns();
    result=await jsonDecode(result.body)['campaigns'];
    result.forEach((element) {
      if(_onGoingCampaign.any((ele) => ele.id == element['_id'])){
        var index=_onGoingCampaign.indexWhere((ele) => ele.id == element['_id']);
        _onGoingCampaign[index]=OnGoingCampaign(
          status: element['status'],
          name: element['name'],
          id: element['_id'],
          created_at: element['created_at'],
          image: element['image'],
          cover_image: element['cover_image'],
          campaign_description: element['campaign_description'],
          collection_address: element['collection_address'],
          description: element['description'],
          is_nft_added: element['is_nft_added'],
          media: element['media'],
          media_type: element['media_type'],
          nft_count: element['nft_count'],
          total_available_nfts: element['total_available_nfts'],
          total_nfts: element['total_nfts'],
          user_id: element['user_id'],
          nft: element['nft'],
        );
      }else{
        _onGoingCampaign.add(OnGoingCampaign(
          status: element['status'],
          name: element['name'],
          id: element['_id'],
          created_at: element['created_at'],
          image: element['image'],
          cover_image: element['cover_image'],
          campaign_description: element['campaign_description'],
          collection_address: element['collection_address'],
          description: element['description'],
          is_nft_added: element['is_nft_added'],
          media: element['media'],
          media_type: element['media_type'],
          nft_count: element['nft_count'],
          total_available_nfts: element['total_available_nfts'],
          total_nfts: element['total_nfts'],
          user_id: element['user_id'],
          nft: element['nft'],
        ));
      }
      notifyListeners();
    });
   }













}


class OnGoingCampaign{
  String? id;
  String? user_id;
  String? name;
  String? cover_image;
  String? image;
  String? description;
  String? media;
  String? media_type;
  String? campaign_description;
  String? created_at;
  int? nft_count;
  String? status;
  String? collection_address;
  bool? is_nft_added;
  int? total_available_nfts;
  int? total_nfts;
  var nft;
  OnGoingCampaign({
    this.id,
    this.user_id,
    this.nft,
    this.name,
    this.cover_image,
    this.image,
    this.description,
    this.media,
    this.media_type,
    this.campaign_description,
    this.created_at,
    this.nft_count,
    this.status,
    this.collection_address,
    this.is_nft_added,
    this.total_available_nfts,
    this.total_nfts,
});
}