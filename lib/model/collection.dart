
class Collection{
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
  Collection({
    this.id,
    this.user_id,
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
    this.nft,


});
}