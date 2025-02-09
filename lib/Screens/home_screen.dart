import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:informer/Models/general_news_model.dart';
import 'package:informer/Screens/categories_screen.dart';
import 'package:informer/Screens/news_detail.dart';
import 'package:informer/Screens/top_head_detail.dart';
import 'package:informer/Text%20Style/textstyle.dart';
import 'package:informer/Models/top_headlines_model.dart';
import 'package:informer/View%20Model/top_head_view_model.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  News_View_Model news_view_model = News_View_Model();

  final format = DateFormat('MMMM dd,yyyy');

// CHANNEL NAME

  String channel_name = 'al-jazeera-english';

  final ScrollController vertical_scroll = ScrollController();
  final ScrollController horizontal_scroll = ScrollController();

  TextEditingController search_country_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => categories_screen()));
            },
            icon: Icon(Icons.menu)),
        title: Text(
          'Informer',
          style: infromer_heading_style,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              color: Colors.white,
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.black,
              ),
              onSelected: (value) {
                setState(() {
                  channel_name = value;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 'al-jazeera-english',
                      child: Text('Al- Jazeera English'),
                    ),
                    PopupMenuItem(
                      value: 'ary-news',
                      child: Text('ARY News'),
                    ),
                    PopupMenuItem(
                      value: 'bloomberg',
                      child: Text('Bloomberg'),
                    ),
                    PopupMenuItem(
                      value: 'bbc-news',
                      child: Text('BBC News'),
                    ),
                  ])
        ],
      ),
      body: SizedBox(
        height: sh,
        child: FutureBuilder<List<dynamic>>(
            future: Future.wait([
              news_view_model.get_top_head_response(channel_name),
              news_view_model.get_location_news(),
              news_view_model.get_current_location(),
            ]),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitFadingFour(
                  size: 40,
                  color: Colors.black,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else {
                top_headlines_model top_headlines =
                    snapshot.data![0] as top_headlines_model;

                general_news_model location_news =
                    snapshot.data![1] as general_news_model;

                String current_location = snapshot.data![2] as String;
                return CustomScrollView(slivers: [
// --- Horizontal Scrolling

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: sh / 3,
                      child: ListView.builder(
                        
                          itemCount: top_headlines.articles!.length,
                          itemExtent: sw / 1.5,
                          scrollDirection: Axis.horizontal,
                          controller: horizontal_scroll,
                          itemBuilder: (context, index) {
                            DateTime datetime = DateTime.parse(
                                top_headlines.articles![index].publishedAt!);

                            return GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> top_head_detail( content: top_headlines
                                        .articles![index].description,
                                    title: top_headlines.articles![index].title,
                                    image:
                                        '${top_headlines.articles?[index].urlToImage}',
                                    source: top_headlines
                                        .articles![index].source!.name,
                                    time: format.format(datetime),))),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: sw / 3,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: sh / 2,
                                      width: sw / 1.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                    child: Container(
                                                      height: sh / 2,
                                                      width: sw / 1.5,
                                                      color: Colors.white,
                                                    ),
                                                    baseColor: Colors.grey,
                                                    highlightColor:
                                                        Colors.grey.shade400),
                                            errorWidget: (context, url, error) =>
                                                Icon(
                                                  Icons.error_outline,
                                                  color: Colors.red,
                                                ),
                                            //
                                            imageUrl:
                                                '${top_headlines.articles?[index].urlToImage ?? 'https://images.pexels.com/photos/10526880/pexels-photo-10526880.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'}'),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: sw / 40,
                                        left: sw / 25,
                                        child: SizedBox(
                                          height: sh / 8,
                                          width: sw / 1.8,
                                          child: Card(
                                              color: Colors.white,
                                              elevation: 2,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: sw / 50,
                                                    right: sw / 50),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: sh / 90,
                                                    ),
                                                    AutoSizeText(
                                                      maxLines: 3,
                                                      maxFontSize: 12,
                                                      minFontSize: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      top_headlines
                                                          .articles![index].title!
                                                          .toString(),
                                                      style:
                                                          card_news_title_style,
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: sw / 150),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          AutoSizeText(
                                                            maxLines: 2,
                                                            maxFontSize: 12,
                                                            minFontSize: 10,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            top_headlines
                                                                .articles![index]
                                                                .source!
                                                                .name
                                                                .toString(),
                                                            style:
                                                                card_news_source_style,
                                                          ),
                                                          Text(
                                                            format
                                                                .format(datetime),
                                                            style:
                                                                card_news_date_style,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),

// Current Country Name

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: sw / 20, top: sw / 40, bottom: sw / 40),
                      child: Row(
                        children: [
                          Text(
                            'News for ${current_location}',
                            style: location_news_title_depth_style,
                          )
                        ],
                      ),
                    ),
                  ),

// --- Vertical Scrolling

                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: location_news.articles!.length,
                          (context, index) {
                    DateTime datetime = DateTime.parse(
                        location_news.articles![index].publishedAt!);
                    return ListTile(
                      tileColor:
                          index % 2 == 0 ? Colors.grey.shade300 : Colors.white,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => news_detail(
                                    content: location_news
                                        .articles![index].description,
                                    title: location_news.articles![index].title,
                                    image:
                                        '${location_news.articles?[index].urlToImage}',
                                    source: location_news
                                        .articles![index].source!.name,
                                    time: format.format(datetime),
                                  ))),
                      leading: SizedBox(
                        height: sh / 5,
                        width: sw / 3.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                  baseColor: Colors.grey.shade500,
                                  highlightColor: Colors.grey.shade300),
                              imageUrl:
                                  '${location_news.articles?[index].urlToImage ?? 'https://media.istockphoto.com/id/1359079740/vector/unavailable-rubber-grunge-stamp-seal-vector-illustration.jpg?s=612x612&w=0&k=20&c=cPKrXPUbmctDEwnWrLvRrQ05yxLIipyMawtzgmQa5lE='}'),
                        ),
                      ),
                      title: Text(
                        '${location_news.articles![index].title}',
                        style: categories_title_style,
                        maxLines: 3,
                      ),
                      subtitle: Text(
                        'Read more',
                        style: categories_read_more_style,
                      ),
                      trailing: SizedBox(
                        height: 50,
                        width: sw / 4.19,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: sh / 70,
                            ),
                            Text(
                              '${format.format(datetime)}',
                              style: categories_date_style,
                            ),
                            Text(
                              textAlign: TextAlign.right,
                              '${location_news.articles![index].source!.name}',
                              style: categories_news_source_style,
                            )
                          ],
                        ),
                      ),
                    );
                  }))
                ]);
              }
            }),
      ),
    );
  }
}
