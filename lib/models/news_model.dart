class NewsModel{
  final String author;
  final String title;
  final String description;
  final String img;
  final String date;
  final String url;

  NewsModel(this.author, this.title, this.description, this.img, this.date, this.url);

  NewsModel.fromJson(Map<String, dynamic> json)
      : author = json['author'] ?? '', title = json['title']?? '',
        description = json['description']?? '', img = json['urlToImage']?? '',
        date =json['publishedAt']?? '', url = json['url']?? '';
}

class NewsResponse{
  final List<NewsModel> news;
  final dynamic error ;

  NewsResponse(this.news, this.error);

  NewsResponse.fromJson(Map<String, dynamic> json)
      : news = (json['articles'] as List).map((e) => NewsModel.fromJson(e)).toList(),
        error = '';

  NewsResponse.showError(dynamic errorValue)
      : news = [], error = errorValue.toString();

}

