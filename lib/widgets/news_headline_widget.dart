import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:text_reader/utils.dart';
import '../screens/view_news_screen.dart';

class NewHeadlineWidget extends StatelessWidget {

  final String author;
  final String title;
  final String description;
  final String img;
  final String date;
  final String url;

  NewHeadlineWidget(this.author, this.title, this.description, this.img, this.date, this.url);

  FlutterTts tts = FlutterTts();

  void _stop() async{
    await tts.setLanguage('en-us');
    await tts.stop();
  }

  speak(String text) async {
    await tts.setLanguage('en-US');
    await tts.setPitch(1);
    await tts.setVolume(1);
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 5, bottom: 10),
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Expanded(
              child: img == '' ? Container() : Image(
                width: MediaQuery.of(context).size.width * 0.33,
                height: 140,
                image: NetworkImage(img),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:10, right: 6 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: textStyle(16, Colors.black, FontWeight.w600),
                    ),
                    SizedBox(height: 3,),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(author,
                            style: textStyle(14, Colors.grey,FontWeight.bold),
                          ),),
                          Text(
                            date == '' ? '' : DateFormat.yMd().format(DateTime.parse(date)),
                            style: textStyle(14, Colors.grey,FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () => speak('hello'),
                                child: Icon(Icons.play_arrow_sharp,size: 43,color: Colors.yellow)),

                            InkWell(
                                onTap: _stop,
                                child: Icon(Icons.stop,size: 43,color: Colors.black)),
                          ],
                        ),

                        Container(
                          width: 70,
                          height: 35,
                          child: TextButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewNewsScreen(url))),
                            style: TextButton.styleFrom(backgroundColor: Colors.yellow),
                            child: Text('View',
                              style: textStyle(15, Colors.black, FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,)
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
