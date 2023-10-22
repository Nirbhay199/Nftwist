class Follower {
  String? id;
  String? follow_by_id;
  String? follow_by_first_name;
  int? follow_by_user_type;
  String? follow_by_last_name;
  String? follow_by_user_name;
  String? follow_by_nick_name;
  String? follow_by_wallet_address;
  String? follow_by_profile_pic;
  String? follow_by_gender;
  var created_at;
  Follower(
      {
        required this.created_at,
        required this.id,
        required this.follow_by_first_name,
        required this.follow_by_gender,
        required this.follow_by_id,
        required this.follow_by_user_type,
        required this.follow_by_last_name,
        required this.follow_by_nick_name,
        required this.follow_by_profile_pic,
        required this.follow_by_user_name,
        required this.follow_by_wallet_address});
}
