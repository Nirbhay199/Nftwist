class Voucher {
  int? tokenId;
  int? minPrice;
  int? auctionType;
  int? quantity;
  int? endTime;
  int? salt;

  Voucher(
      {this.tokenId,
        this.minPrice,
        this.auctionType,
        this.quantity,
        this.endTime,
        this.salt});

  Voucher.fromJson(Map<String, dynamic> json) {
    tokenId = json['tokenId'];
    minPrice = json['minPrice'];
    auctionType = json['auctionType'];
    quantity = json['quantity'];
    endTime = json['endTime'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tokenId'] = tokenId;
    data['minPrice'] = minPrice;
    data['auctionType'] = auctionType;
    data['quantity'] = quantity;
    data['endTime'] = endTime;
    data['salt'] = salt;
    return data;
  }
}