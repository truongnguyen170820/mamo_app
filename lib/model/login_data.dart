class LoginData {
  String idStr;

  String sessionId;
  String userName;
  String email;
  String mobile;
  num userType;
  String fullName;
  String gender;
  String birthday;
  String address;
  String avatarUrl;
  String appName;
  String momoMobile;
  String momoName;
  bool isGetBonusIntruduceCode;
  Account account;

  LoginData(
      {this.idStr,
      this.sessionId,
      this.userName,
      this.email,
      this.mobile,
      this.userType,
      this.fullName,
      this.gender,
      this.birthday,
      this.address,
      this.avatarUrl,
      this.appName,
      this.momoMobile,
      this.momoName,
      this.isGetBonusIntruduceCode,
      this.account});

  LoginData.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    sessionId = json['SessionId'];
    userName = json['UserName'];
    email = json['Email'];
    mobile = json['Mobile'];
    userType = json['UserType'];
    fullName = json['FullName'];
    gender = json['Gender'];
    birthday = json['Birthday'];
    address = json['Address'];
    avatarUrl = json['AvatarUrl'];
    appName = json['AppName'];
    momoMobile = json['MomoMobile'];
    momoName = json['MomoName'];
    isGetBonusIntruduceCode = json['IsGetBonusIntruduceCode'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['SessionId'] = this.sessionId;
    data['UserName'] = this.userName;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['UserType'] = this.userType;
    data['FullName'] = this.fullName;
    data['Gender'] = this.gender;
    data['Birthday'] = this.birthday;
    data['Address'] = this.address;
    data['AvatarUrl'] = this.avatarUrl;
    data['AppName'] = this.appName;
    data['MomoMobile'] = this.momoMobile;
    data['MomoName'] = this.momoName;
    data['IsGetBonusIntruduceCode'] = this.isGetBonusIntruduceCode;
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    return data;
  }
}

class Account {
  String idStr;
  String createdDateStr;
  String description;
  num preBalance;
  String lastChangedDateStr;
  // Null accountNumber;
  num currency;
  String userIdStr;
  String username;
  num prePoint;
  num point;
  num level;
  num status;
  // Null introduceCode;
  bool isGetBonusIntruduceCode;
  bool isModeTest;
  num balance;
  num totalBalance;
  num totalBalanceReadStory;
  num totalBalanceReadNews;
  num totalBalanceViewVideo;
  num totalBalanceAffiliate;
  num totalPageReadStory;
  num totalPageReadNews;
  num totalMinuteViewVideo;

  Account(
      {this.idStr,
      this.createdDateStr,
      this.description,
      this.preBalance,
      this.lastChangedDateStr,
      // this.accountNumber,
      this.currency,
      this.userIdStr,
      this.username,
      this.prePoint,
      this.point,
      this.level,
      this.status,
      // this.introduceCode,
      this.isGetBonusIntruduceCode,
      this.isModeTest,
      this.balance,
      this.totalBalance,
      this.totalBalanceReadStory,
      this.totalBalanceReadNews,
      this.totalBalanceViewVideo,
      this.totalBalanceAffiliate,
      this.totalPageReadStory,
      this.totalPageReadNews,
      this.totalMinuteViewVideo});

  Account.fromJson(Map<String, dynamic> json) {
    idStr = json['IdStr'];
    createdDateStr = json['CreatedDateStr'];
    description = json['Description'];
    preBalance = json['PreBalance'];
    lastChangedDateStr = json['LastChangedDateStr'];
    // accountNumber = json['AccountNumber'];
    currency = json['Currency'];
    userIdStr = json['UserIdStr'];
    username = json['Username'];
    prePoint = json['PrePoint'];
    point = json['Point'];
    level = json['Level'];
    status = json['Status'];
    // introduceCode = json['IntroduceCode'];
    isGetBonusIntruduceCode = json['IsGetBonusIntruduceCode'];
    isModeTest = json['IsModeTest'];
    balance = json['Balance'];
    totalBalance = json['TotalBalance'];
    totalBalanceReadStory = json['TotalBalanceReadStory'];
    totalBalanceReadNews = json['TotalBalanceReadNews'];
    totalBalanceViewVideo = json['TotalBalanceViewVideo'];
    totalBalanceAffiliate = json['TotalBalanceAffiliate'];
    totalPageReadStory = json['TotalPageReadStory'];
    totalPageReadNews = json['TotalPageReadNews'];
    totalMinuteViewVideo = json['TotalMinuteViewVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdStr'] = this.idStr;
    data['CreatedDateStr'] = this.createdDateStr;
    data['Description'] = this.description;
    data['PreBalance'] = this.preBalance;
    data['LastChangedDateStr'] = this.lastChangedDateStr;
    // data['AccountNumber'] = this.accountNumber;
    data['Currency'] = this.currency;
    data['UserIdStr'] = this.userIdStr;
    data['Username'] = this.username;
    data['PrePoint'] = this.prePoint;
    data['Point'] = this.point;
    data['Level'] = this.level;
    data['Status'] = this.status;
    // data['IntroduceCode'] = this.introduceCode;
    data['IsGetBonusIntruduceCode'] = this.isGetBonusIntruduceCode;
    data['IsModeTest'] = this.isModeTest;
    data['Balance'] = this.balance;
    data['TotalBalance'] = this.totalBalance;
    data['TotalBalanceReadStory'] = this.totalBalanceReadStory;
    data['TotalBalanceReadNews'] = this.totalBalanceReadNews;
    data['TotalBalanceViewVideo'] = this.totalBalanceViewVideo;
    data['TotalBalanceAffiliate'] = this.totalBalanceAffiliate;
    data['TotalPageReadStory'] = this.totalPageReadStory;
    data['TotalPageReadNews'] = this.totalPageReadNews;
    data['TotalMinuteViewVideo'] = this.totalMinuteViewVideo;
    return data;
  }
}
