class RecentRewardReader {
  String fullName;
  String userName;
  num amount;
  String transationTimeStr;
  num readType;

  RecentRewardReader(
      {this.fullName,
      this.userName,
      this.amount,
      this.transationTimeStr,
      this.readType});

  RecentRewardReader.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    userName = json['UserName'];
    amount = json['Amount'];
    transationTimeStr = json['TransationTimeStr'];
    readType = json['ReadType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['UserName'] = this.userName;
    data['Amount'] = this.amount;
    data['TransationTimeStr'] = this.transationTimeStr;
    data['ReadType'] = this.readType;
    return data;
  }
}
