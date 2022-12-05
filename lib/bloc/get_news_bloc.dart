import 'package:rxdart/rxdart.dart';
import 'package:text_reader/repository/news_repo.dart';
import '../models/news_model.dart';

class GetNewsBloc {
  final NewsRepository newsRepository = NewsRepository();
  final BehaviorSubject<NewsResponse> _subject = BehaviorSubject<NewsResponse>();

  BehaviorSubject<NewsResponse> get subject => _subject;

  getNews(dynamic category, dynamic country) async {
    NewsResponse newsResponse = await newsRepository.getNews(category, country);
    _subject.sink.add(newsResponse);
  }
  dispose(){
    _subject.close();
  }
}