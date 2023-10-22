class Following {
  String? id;
  String? follow_id;
  String? follow_first_name;
  int? follow_user_type;
  String? follow_last_name;
  String? follow_user_name;
  String? follow_nick_name;
  String? follow_wallet_address;
  String? follow_profile_pic;
  String? follow_gender;
  var created_at;
  Following(
      {
      required this.created_at,
      required this.id,
      required this.follow_first_name,
      required this.follow_gender,
      required this.follow_id,
      required this.follow_user_type,
      required this.follow_last_name,
      required this.follow_nick_name,
      required this.follow_profile_pic,
      required this.follow_user_name,
      required this.follow_wallet_address});
}
