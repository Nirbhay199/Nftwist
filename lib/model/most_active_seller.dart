class ActivePartner{
  String? id;
  GifterData? gifter_data;
  int? total_copies;
  ActivePartner({required this.id,required this.gifter_data,required this.total_copies});
}


class GifterData{
  String? id;
  String? first_name;
  String? last_name;
  String? user_name;
  String? nick_name;
  String? profile_pic;
  GifterData({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.user_name,
    required this.nick_name,
    required this.profile_pic,
});
}