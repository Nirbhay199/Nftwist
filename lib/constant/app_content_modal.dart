enum  type{PRIVACY_POLICY, TERMS_AND_CONDITIONS}


class Faq{
  String? id;
  String? question;
  String? answer;
  String? created_at;
  Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.created_at,
});
}
class AppPrivacy{
  String? type;
  String? id;
  String? name;
  String? text;
  String? link;
  String? createdAt;
  String? updatedAt;
  int? v;
  AppPrivacy({
    this.id,this.text,this.name,this.type,this.createdAt,this.link,this.updatedAt,this.v
});
}
class AppTERMS{
  String? type;
  String? id;
  String? name;
  String? text;
  String? link;
  String? createdAt;
  String? updatedAt;
  int? v;
  AppTERMS({
    this.id,this.text,this.name,this.type,this.createdAt,this.link,this.updatedAt,this.v
});
}