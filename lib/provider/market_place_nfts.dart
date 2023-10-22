import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nftwist/model/Voucher.dart' as voucher;
import 'package:nftwist/model/nft_detail.dart';

 import '../constant/toaster.dart';
import '../model/home_module_model_data.dart';
import '../model/most_active_seller.dart';
import '../model/newsfeeds_model.dart';
import '../model/partnersNfts-model.dart';
import '../services/api_response_handler.dart';
import '../services/locator.dart';

class Nfts with ChangeNotifier {
  NftDetail _nftDetail = NftDetail();
  int currentPage=0;
  int itemsPerPage = 10;
  int totalCount=0;
  List<String>? collection;
  NftDetail get nftDetail {
    return _nftDetail;
  }

  List<ActivePartner> _activePartner = [];
  List<ActivePartner> get activePartner {
    return _activePartner;
  }

   List<MarketPlaceNfts> _marketPlaceNfts = [];
  List<MarketPlaceNfts> get marketPlaceNfts {
    return _marketPlaceNfts;
  }
   List<FeaturedNew> _newsFeeds = [];
  List<FeaturedNew> get newsFeeds {
    return _newsFeeds;
  }

   List<PartnerNftsModel> _partnerNFTs = [];
  List<PartnerNftsModel> get partnerNFTs {
    return _partnerNFTs;
  }
/*----Partner-----*/
  getPartnerList(data){
    data.forEach((ele) {
      if (_partnerNFTs.any((element) => element.sId == ele['_id'])) {
        int? index =
        _partnerNFTs.indexWhere((element) => element.sId == ele['_id']);
        _partnerNFTs[index] = PartnerNftsModel.fromJson(ele);
      } else {
        _partnerNFTs.add(PartnerNftsModel.fromJson(ele));
      }
    });
  }


  setFilter(collection)async {
    this.collection=collection;
    notifyListeners();
    return true;
  }


  getPartnerNFTs() async {
    if(totalCount>_partnerNFTs.length||totalCount==0){
      var response = await ApiResponse().getPartnersNfts(limit: itemsPerPage,page: currentPage,collection: collection);
      var data = await jsonDecode(response.body);
      if(response.statusCode==200){
        totalCount=data["response"]["count"];
        if(data["response"]["data"]!=[]){
          itemsPerPage+=10;
          data["response"]["data"].forEach((ele) {
            if (_partnerNFTs.any((element) => element.sId == ele['_id'])) {
              int? index =
              _partnerNFTs.indexWhere((element) => element.sId == ele['_id']);
              _partnerNFTs[index] = PartnerNftsModel.fromJson(ele);
            } else {
              _partnerNFTs.add(PartnerNftsModel.fromJson(ele));
            }
          });}
        else{
          currentPage+=1;
          itemsPerPage=10;
        }
      }
    }
    notifyListeners();
    return true;
  }
/*----Partner-----*/



  getActivePartner() async {
    var response = await ApiResponse().getActivePartner();
    var data = (await jsonDecode(response.body));
    print(data);
 if(response.statusCode==200){
   print("TOP-------${  data[0]["data"]}");

data[0]['data'].forEach((partners){

  if (_activePartner.any((element) => element.id == partners['_id'])) {
    int? index =
    _activePartner.indexWhere((element) => element.id == partners['_id']);
    _activePartner[index]=ActivePartner(id: partners['_id'],
        gifter_data: GifterData(
            id: partners['gifter_data'][0]['_id'],
            first_name: partners['gifter_data'][0]['first_name'],
            last_name: partners['gifter_data'][0]['last_name'],
            user_name: partners['gifter_data'][0]['user_name'],
            nick_name: partners['gifter_data'][0]['nick_name'],
            profile_pic: partners['gifter_data'][0]['profile_pic']
        ), total_copies: partners['total_copies']);
  }else {
    if(partners['_id']!=null){
      _activePartner.add(ActivePartner(id: partners['_id'],
          gifter_data: GifterData(
              id: partners['gifter_data'][0]['_id'],
              first_name: partners['gifter_data'][0]['first_name'],
              last_name: partners['gifter_data'][0]['last_name'],
              user_name: partners['gifter_data'][0]['user_name'],
              nick_name: partners['gifter_data'][0]['nick_name'],
              profile_pic: partners['gifter_data'][0]['profile_pic']
          ), total_copies: partners['total_copies']));
    }
  }
  notifyListeners();
});
 }
  }




  getNftDetails(id,{scan,ownerId,refresh=false}) async {
    if(refresh!=true)_nftDetail=NftDetail();
    notifyListeners();
    var response = await ApiResponse().getNFtDetails(id,isScanned:scan,ownerId: ownerId);
    var data = (await jsonDecode(response.body));
    print(data);
    if(response.statusCode==200){
    _nftDetail = NftDetail(
      id: data['_id'],
      user_id: NftUserId(
          id: id,
          email: data['user_id']['email'].toString(),
          firstName: data['user_id']['first_name'].toString(),
          userType: data['user_id']['user_type'],
          coverImage: data['user_id']['cover_image'],
          lastName: data['user_id']['last_name'].toString(),
          userName: data['user_id']['user_name'],
          walletAddress: data['user_id']['wallet_address'],
          profilePic: data['user_id']['profile_pic'].toString(),
          bio: data['user_id']['bio'],
          personalLink: data['user_id']['personal_link'],
          walletId: data['user_id']['wallet_id']),resellers: data['resellers'],owners:data['owners'],
      collection_id: CollectionId(
          id: data['collection_id']['_id'],
          name: data['collection_id']['name'],
          symbol: data['collection_id']['symbol'],
          media: data['collection_id']['media'],
          media_type: data['collection_id']['media_type'],
          collection_address: data['collection_id']['collection_address']),
      category_id: data['category_id'],
      other_category: data['other_category'],
      type: data['type'],
      media_type: data['media_type'],
      file: data['file'],
      price: data['price'],
      weth_price: data['weth_price'],
      unlockable_content: data['unlockable_content'],
      no_of_copy: data['no_of_copy'],
      name: data['name'],
      description: data['description'],
      alternative_description: data['alternative_description'],
      royalty: data['royalty'],
      current_owner: CurrentOwner(
          reseller_id:data['current_owner'].containsKey('reseller_id')? ResellerId(
              id: data['current_owner']['reseller_id']['_id'].toString(),
              email: data['current_owner']['reseller_id']['email'],
              first_name: data['current_owner']['reseller_id']['first_name'].toString(),
              cover_image: data['current_owner']['reseller_id']['cover_image'].toString(),
              last_name: data['current_owner']['reseller_id']['last_name'].toString(),
              user_name: data['current_owner']['reseller_id']['user_name'],
              wallet_address: data['current_owner']['reseller_id']
                  ['wallet_address'],
              profile_pic: data['current_owner']['reseller_id']['profile_pic'],
              bio: data['current_owner']['reseller_id']['bio'],
              personal_link: data['current_owner']['reseller_id']['personal_link'],
              wallet_id: data['current_owner']['reseller_id']['wallet_id']):null,
          id: data['current_owner']['_id'],
          email: data['current_owner']['email'],
          first_name: data['current_owner']['first_name'],
          cover_image: data['current_owner']['cover_image'],
          last_name: data['current_owner']['last_name'],
          user_name: data['current_owner']['user_name'],
          wallet_address: data['current_owner']['wallet_address'],
          profile_pic: data['current_owner']['profile_pic'],
          bio: data['current_owner']['bio'],
          personal_link: data['current_owner']['personal_link'],
          wallet_id: data['current_owner']['wallet_id'],
          nft_id: data['current_owner']['nft_id'],
          nft_owner_id: data['current_owner']['nft_owner_id'],
          price: data['current_owner']['price'],
          earned_amount: data['current_owner']['earned_amount'],
          signature: data['current_owner']['signature'],
          owner_address: data['current_owner']['owner_address'],
          no_of_copy: data['current_owner']['no_of_copy'],
          available: data['current_owner']['available'],
          created_at: data['current_owner']['created_at'],
          is_logged_user_owner: data['current_owner']['is_logged_user_owner'],
          nft_resell_id: data['current_owner']['nft_resell_id'],
          follower_count: data['current_owner']['follower_count'],
          following_count: data['current_owner']['following_count'],
          collection_count: data['current_owner']['collection_count'],
          membership_count: data['current_owner']['membership_count'],
          is_followed: data['current_owner']['is_followed'],
          nft_count: data['current_owner']['nft_count'],
          owner_count: data['current_owner']['owner_count'],
          ),
      voucher:data['voucher']!=null? voucher.Voucher(
          tokenId: data['voucher']['tokenId'],
          salt: data['voucher']['salt'],
          quantity: data['voucher']['quantity'],
          auctionType: data['voucher']['auctionType'],
          endTime: data['voucher']['endTime'],
          minPrice: data['voucher']['minPrice']):null,
      status: data['status'],
      owner_wallet_address: data['owner_wallet_address'],
      auction_id: data['auction_id'],
      auction_time: data['auction_time'],
      auction_type: data['auction_type'],
      available: data['available'],
      blockchain: data['blockchain'],
      commented_user_count: data['commented_user_count'],
      comments: data['comments'],
      created_at: data['created_at'],
      creator_wallet_address: data['creator_wallet_address'],
      data_ipfs: data['data_ipfs'],
      dollar_value: data['dollar_value'],
      extra_content: data['extra_content'],
      gifted_nft_id: data['gifted_nft_id'],
      is_auction_window: data['is_auction_window'],
      is_commented: data['is_commented'],
      is_extra_content: data['is_extra_content'],
      is_gifted: data['is_gifted'],
      is_hot: data['is_hot'],
      is_lazy_mint: data['is_lazy_mint'],
      is_liked: data['is_liked']==1?true:false,
      is_most_visible: data['is_most_visible'],
      is_on_market_place: data['is_on_market_place'],
      is_owner: data['is_owner'],
      creator: Creator(id:data['creator']['_id'],user_type:data['creator']['user_type'],user_name:data['creator']['user_name'],last_name:data['creator']['last_name'].toString(),first_name:data['creator']['first_name'].toString(),email:data['creator']['email'],bio:data['creator']['bio'],cover_image:data['creator']['cover_image'],personal_link:data['creator']['personal_link'],profile_pic:data['creator']['profile_pic'],wallet_address:data['creator']['wallet_address'],wallet_id:data['creator']['wallet_id']),
      is_private: data['is_private'],
      nft_comment_count: data['nft_comment_count'],
      nft_like_count: data['nft_like_count'],
      properties: data['properties'],
      signature: data['signature'],
      token_id: data['token_id'],
      transaction_hash: data['transaction_hash'],
      txn_id: data['txn_id'],
      viewer_id: data['viewer_id'],
    );}else{
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    int index = _partnerNFTs.indexWhere((element) => element.sId == id);
    if(index!=-1) {
      var nft = _partnerNFTs[index];
      nft.likesCount=_nftDetail.nft_like_count;
      nft.is_liked=_nftDetail.is_liked;
    }
    notifyListeners();
    return false;
  }
  /*----MarketPlace----*/
  getMarketPlaceNft({page,limit}) async {
    var response = await ApiResponse().getMarketPlaceNftResponse(limit: limit,page: page);
    var data = (await jsonDecode(response.body));
    data.forEach((ele) {
      _marketPlaceNfts.add(MarketPlaceNfts.fromJson(ele));
    });
    notifyListeners();
  }
  getList(data){
    data.forEach((ele) {
      _marketPlaceNfts.add(MarketPlaceNfts.fromJson(ele));
    });
  }
  /*----MarketPlace----*/

  getNewsFeeds() async {
    var response = await ApiResponse().getNewsFeed();
    var data = (await jsonDecode(response.body));
    // print("NEWS----${data['response']['data']}");
    try{
      data['response']['data'].forEach((ele) {
        if (_newsFeeds.any((element) => element.id == ele['_id'])) {
          int? index =
          _newsFeeds.indexWhere((element) => element.id == ele['_id']);
          _newsFeeds[index] = FeaturedNew(
              id: ele['_id'],
              user_id: ele['user_id'],
              name: ele['name'],
              description: ele['description'],
              type: ele['type'],
              file: ele['file'],
              media_type: ele['media_type'],
              collection_name: ele['collection_name'],
              collection_symbol: ele['collection_symbol'],
              price: ele['price'],
              first_name: ele['first_name'],
              last_name: ele['last_name'],
              user_name: ele['user_name'],
              email: ele['email'],
              owner_wallet_address: ele['owner_wallet_address'],
              owner_wallet_id: ele['owner_wallet_id'],
              profile_pic: ele['profile_pic'],
              is_on_market_place: ele['is_on_market_place'],
              available: ele['available'],
              created_at: ele['created_at'],
              is_private: ele['is_private'],
              no_of_copy_on_market_place: ele['no_of_copy_on_market_place'],
              no_of_copy: ele['no_of_copy'],
              likes_count: ele['likes_count'],
              comment_count: ele['comment_count'],
              is_liked: ele['is_liked']);
        } else {
          _newsFeeds.add(FeaturedNew(
              id: ele['_id'],
              user_id: ele['user_id'],
              name: ele['name'],
              description: ele['description'],
              type: ele['type'],
              file: ele['file'],
              media_type: ele['media_type'],
              collection_name: ele['collection_name'],
              collection_symbol: ele['collection_symbol'],
              price: ele['price'],
              first_name: ele['first_name'].toString(),
              last_name: ele['last_name'].toString(),
              user_name: ele['user_name'],
              email: ele['email'],
              owner_wallet_address: ele['owner_wallet_address'],
              owner_wallet_id: ele['owner_wallet_id'],
              profile_pic: ele['profile_pic'],
              is_on_market_place: ele['is_on_market_place'],
              available: ele['available'],
              created_at: ele['created_at'],
              is_private: ele['is_private'],
              no_of_copy_on_market_place: ele['no_of_copy_on_market_place'],
              no_of_copy: ele['no_of_copy'],
              likes_count: ele['likes_count'],
              comment_count: ele['comment_count'],
              is_liked: ele['is_liked']));
        }
      });
    }catch(_){
      print("-------78$_");
    }
   notifyListeners();
    return true;
  }


  ///--------type=1,2 userNft,partnerNft
  likeNft(id,{type=2,isDetails}) async {
    if(isDetails==true){
      print(_nftDetail.is_liked);
      bool isLiked =  _nftDetail.is_liked??false;
      if (isLiked) {
        _nftDetail.nft_like_count = (_nftDetail.nft_like_count ?? 0) - 1;
      } else {
        _nftDetail.nft_like_count = (_nftDetail.nft_like_count ?? 0) + 1;
      }
      _nftDetail.is_liked = !isLiked;
    }
     if(type==1){
       try{
       /*  int? index =
         _marketPlaceNfts[0].data?.indexWhere((element) => element.sId == id);
         print(index);
         if (index != null) {
           int count = (_marketPlaceNfts[0].data?[index].likesCount)!;
           if (_marketPlaceNfts[0].data?[index].isLiked == false) {
             _marketPlaceNfts[0].data?[index].isLiked = true;
             _marketPlaceNfts[0].data?[index].likesCount = count + 1;
           } else {
             _marketPlaceNfts[0].data?[index].isLiked = false;
             _marketPlaceNfts[0].data?[index].likesCount = count - 1;
           }
         }
         if(_nftDetail.id!=null){
           int count = (_nftDetail.nft_like_count)!;
           if (_nftDetail.is_liked == false) {
             _nftDetail.is_liked = true;
             _nftDetail.nft_like_count = count + 1;
           } else {
             _nftDetail.is_liked = false;
             _nftDetail.nft_like_count = count - 1;
           }    }
         int? index_1 =
         _newsFeeds.indexWhere((element) => element.id == id);
         print(index);
         if (index != null) {
           int count = (_newsFeeds[index].likes_count)!;
           if (_newsFeeds[index].is_liked == false) {
             _newsFeeds[index].is_liked = true;
             _newsFeeds[index].likes_count = count + 1;
           } else {
             _newsFeeds[index].is_liked = false;
             _newsFeeds[index].likes_count = count - 1;
           }
         }*/
         int? index = _marketPlaceNfts[0].data?.indexWhere((element) => element.sId == id);

         if (index != -1) {
           var nft = _marketPlaceNfts[0].data![index??0];
           bool isLiked = nft.isLiked ?? false;

           if (isLiked) {
             nft.likesCount = (nft.likesCount ?? 0) - 1;
           } else {
             nft.likesCount = (nft.likesCount ?? 0) + 1;
           }

           nft.isLiked = !isLiked;

           if (_nftDetail.id != null) {
             _nftDetail.is_liked = nft.isLiked;
             _nftDetail.nft_like_count = nft.likesCount;
             int? index_1 =
             _newsFeeds.indexWhere((element) => element.id == id);
             _newsFeeds[index_1].is_liked= nft.isLiked;
             _newsFeeds[index_1].likes_count = nft.likesCount;
           }

           print(nft.likesCount);
           print(isLiked ? "LIKE UNDONE" : "LIKE DONE");
         }
       }catch(_){}
     }else{
       // normal
      /* int? index =
       _partnerNFTs.indexWhere((element) => element.sId == id);
       print(_partnerNFTs[index].likesCount);
       print(_partnerNFTs[index].is_liked);
       int count = (_partnerNFTs[index].likesCount)!;
       if (_partnerNFTs[index].is_liked == false||_partnerNFTs[index].is_liked == null) {
         print("LIKE DONE");
         _partnerNFTs[index].is_liked = true;
         _partnerNFTs[index].likesCount = count + 1;
       } else {
         _partnerNFTs[index].is_liked = false;
         _partnerNFTs[index].likesCount = count - 1;

       }
       if(_nftDetail.id!=null){
        _nftDetail.is_liked=_partnerNFTs[index].is_liked;
        _nftDetail.nft_like_count=_partnerNFTs[index].likesCount;
       }*/


       //optimise1
       /*int? index = _partnerNFTs.indexWhere((element) => element.sId == id);
       if (index != -1) {
         final nft = _partnerNFTs[index];
         if (nft.is_liked == false || nft.is_liked == null) {
           print("LIKE DONE");
           nft.is_liked = true;
           nft.likesCount= (nft.likesCount??0)+1;
         } else {
           nft.is_liked = false;
           nft.likesCount= (nft.likesCount??1)-1;
         }
         if (_nftDetail.id != null) {
           _nftDetail.is_liked = nft.is_liked;
           _nftDetail.nft_like_count = nft.likesCount;
         }
         print(nft.likesCount);
       }*/

       //optimise2
       print("ffdkjfdjfk");
       int? index = _partnerNFTs.indexWhere((element) => element.sId == id);

       if (index != -1) {
         var nft = _partnerNFTs[index];
         bool isLiked = nft.is_liked ?? false;
         if (isLiked) {
           nft.likesCount = (nft.likesCount ?? 0) - 1;
         } else {
           nft.likesCount = (nft.likesCount ?? 0) + 1;
         }

         nft.is_liked = !isLiked;
         print(nft.is_liked);
         print(_partnerNFTs[index].is_liked);
         if (_nftDetail.id != null) {
           _nftDetail.is_liked = nft.is_liked;
           _nftDetail.nft_like_count = nft.likesCount;
         }

         print(isLiked ? "LIKE UNDONE" : "LIKE DONE");
       }
          }
    notifyListeners();
     final a=await ApiResponse().likeNft(id);
     print("LIST------${a.body}");
  }

  addComments(text,id,first_name,last_name,profile_pic,wallet_address)async{
  var result=await ApiResponse().addComments(text,id);
  var data=await jsonDecode(result.body);
  if(result.statusCode==200){
    _nftDetail.comments.insert(0,{
     "_id": "t6$id",
     "user_id": id,
     "comment": text,
     "first_name": first_name,
     "last_name": last_name,
     "profile_pic": profile_pic,
    "wallet_address": wallet_address,
    "created_at": DateTime.now().subtract(const Duration(seconds: 2)).toString(),
    "like_count": 0,
    "is_liked": false,
    "is_my_comment": true,
    "comment_replies": []});
    notifyListeners();
  }else{
    locator<Toaster>().showToaster(msg: data["error_description"]);
  }
  }

  deleteData(){
    _marketPlaceNfts=[];
    _newsFeeds=[];
    notifyListeners();
  }



}
