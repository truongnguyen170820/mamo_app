class HomeStatitics {
  num numPageReadStory;
  num numPageReadNews;
  num numDurationViewVideo;
  num totalMoney;
  num totalMoneyReadStory;
  num totalMoneyReadNews;
  num totalMoneyViewVideo;

  HomeStatitics(
      {this.numPageReadStory,
      this.numPageReadNews,
      this.numDurationViewVideo,
      this.totalMoney,
      this.totalMoneyReadStory,
      this.totalMoneyReadNews,
      this.totalMoneyViewVideo});

  HomeStatitics.fromJson(Map<String, dynamic> json) {
    numPageReadStory = json['NumPageReadStory'];
    numPageReadNews = json['NumPageReadNews'];
    numDurationViewVideo = json['NumDurationViewVideo'];
    totalMoney = json['TotalMoney'];
    totalMoneyReadStory = json['TotalMoneyReadStory'];
    totalMoneyReadNews = json['TotalMoneyReadNews'];
    totalMoneyViewVideo = json['TotalMoneyViewVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NumPageReadStory'] = this.numPageReadStory;
    data['NumPageReadNews'] = this.numPageReadNews;
    data['NumDurationViewVideo'] = this.numDurationViewVideo;
    data['TotalMoney'] = this.totalMoney;
    data['TotalMoneyReadStory'] = this.totalMoneyReadStory;
    data['TotalMoneyReadNews'] = this.totalMoneyReadNews;
    data['TotalMoneyViewVideo'] = this.totalMoneyViewVideo;
    return data;
  }
}
