import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:informer/Text%20Style/textstyle.dart';
import 'package:informer/View%20Model/top_head_view_model.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class categories_screen extends StatefulWidget {
  const categories_screen({super.key});

  @override
  State<categories_screen> createState() => _categories_screenState();
}

class _categories_screenState extends State<categories_screen> {
  News_View_Model news_view_model = News_View_Model();

  String category_name = 'sports';

  List<String> categories_list = [
    'sports',
    'technology',
    'entertainment',
    'business'
  ];

  final format = DateFormat('MMMM dd, yyyy');

  bool is_selected = false;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Categories',
          style: categories_heading_style,
        ),
        bottom: PreferredSize(
          preferredSize: Size(sw / 1, sh / 18),
          child: SizedBox(
            height: sh / 18,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories_list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        category_name = categories_list[index];
                      });
                    },
                    child: Container(
                      width: sw / 4,
                      margin: EdgeInsets.only(
                          top: sw / 75,
                          bottom: sw / 75,
                          left: sw / 74,
                          right: sw / 74),
                      decoration: BoxDecoration(
                        color: category_name == categories_list[index]
                            ? Colors.black
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        categories_list[index],
                        style: category_name == categories_list[index]
                            ? selected_categories_choice_chip_style
                            : unselected_categories_choice_chip_style,
                      )),
                    ),
                  );
                }),
          ),
        ),
      ),
      body: Column(
        children: [
// Category selection

          SizedBox(
            height: sh / 50,
          ),

          // Category Body

          Expanded(
            child: FutureBuilder(
                future: news_view_model.get_categories(category_name),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SpinKitFadingFour(
                        color: Colors.black,
                        size: 40,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error in loading data..',
                        style: unselected_categories_choice_chip_style,
                      ),
                    );
                  } else {
                    return SizedBox(
                      child: ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            DateTime datetime = DateTime.parse(
                                '${snapshot.data!.articles![index].publishedAt!.toString()}');

                            return Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: ListTile(
                                tileColor: index % 2 == 0
                                    ? Colors.grey.shade300
                                    : Colors.white,
                                contentPadding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                leading: Padding(
                                  padding: EdgeInsets.only(top: sh / 150),
                                  child: SizedBox(
                                    height: sh / 5,
                                    width: sw / 4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return Shimmer.fromColors(
                                                child: Container(
                                                  color: Colors.white,
                                                ),
                                                baseColor: Colors.grey.shade500,
                                                highlightColor:
                                                    Colors.grey.shade300);
                                          },
                                          errorWidget: (context, url, error) {
                                            return Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            );
                                          },
                                          imageUrl:
                                              '${snapshot.data?.articles?[index].urlToImage ?? 'https://media.istockphoto.com/id/1359079740/vector/unavailable-rubber-grunge-stamp-seal-vector-illustration.jpg?s=612x612&w=0&k=20&c=cPKrXPUbmctDEwnWrLvRrQ05yxLIipyMawtzgmQa5lE='}'),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  '${snapshot.data!.articles![index].title}',
                                  style: categories_title_style,
                                  maxLines: 3,
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
                                        '${snapshot.data!.articles![index].source!.name}',
                                        style: categories_news_source_style,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
