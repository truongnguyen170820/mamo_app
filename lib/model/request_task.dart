class RequestTask {
  String url;
  String description;

  RequestTask({this.url, this.description});

  RequestTask.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    data['Description'] = this.description;
    return data;
  }
}