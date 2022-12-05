import 'package:flutter/material.dart';
import 'package:text_reader/bloc/get_news_bloc.dart';
import 'package:text_reader/bloc/select_category_bloc.dart';
import 'package:text_reader/models/news_model.dart';
import 'package:text_reader/utils.dart';
import 'package:text_reader/widgets/news_headline_widget.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late GetNewsBloc getNewsBloc;
  late SelectCategoryBloc selectCategoryBloc;

  @override
  void initState() {
    super.initState();
    getNewsBloc = GetNewsBloc();
    getNewsBloc.getNews('general', 'us');
    selectCategoryBloc = SelectCategoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Tobe Update', style: textStyle(25, Colors.black,FontWeight.w500),),
        actions: [
          StreamBuilder(
            stream: selectCategoryBloc.countryStream,
            initialData: selectCategoryBloc.defaultCountry,
            builder: (context, snapshot) {
              return StreamBuilder(
                stream: selectCategoryBloc.categoryStream,
                initialData: selectCategoryBloc.defaultCategory,
                builder: (context, categorySnapshot) {
                  return DropdownButton(
                    dropdownColor: Colors.white,
                    value: snapshot.data,
                    style: textStyle(20, Colors.black,FontWeight.w700),
                      items: countryCodes.map((code) {
                        return DropdownMenuItem(
                          value: code,
                          child: Text(code),);
                      },).toList(),
                    iconSize: 22,
                    onChanged: (value) {
                      selectCategoryBloc.selectCountry(value);
                      getNewsBloc.getNews(categorySnapshot.data, value);
                    },
                  );
                }
              );
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20,),
            StreamBuilder(
              stream: selectCategoryBloc.categoryStream,
              initialData: selectCategoryBloc.defaultCategory,
              builder: (context, snapshot) {
                return StreamBuilder(
                  stream: selectCategoryBloc.countryStream,
                  initialData: selectCategoryBloc.defaultCountry,
                  builder: (context, countrySnapshot) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category){
                          return Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: InkWell(
                              onTap: () {
                                selectCategoryBloc.selectCategory(category);
                                getNewsBloc.getNews(category, countrySnapshot.data);
                              },
                              child: Text(
                                category,
                                style: textStyle(23,snapshot.data == category ? Colors.black : Colors.grey,FontWeight.w600),),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                );
              }
            ),
            SizedBox(height: 20,),
            StreamBuilder<NewsResponse>(
              stream: getNewsBloc.subject.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                List<NewsModel> newsList = snapshot.data!.news;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: newsList.length,
                  itemBuilder: (context, index){
                    NewsModel news = newsList[index];
                    return NewHeadlineWidget(
                      news.author == null ? '': news.author,
                      news.title == null ? '': news.title,
                      news.description == null ? '': news.description,
                      news.img == null ? '': news.img,
                      news.date == null ? '': news.date,
                      news.url ,
                    );
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
