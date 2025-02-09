import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:informer/Text%20Style/textstyle.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class top_head_detail extends StatefulWidget {
  final image, title, content, source, time;

  top_head_detail(
      {required this.content,
      required this.title,
      required this.image,
      required this.source,
      required this.time});

  @override
  State<top_head_detail> createState() => _top_head_detailState();
}

class _top_head_detailState extends State<top_head_detail> {
  final format = DateFormat('MMMM dd,yyyy');

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'Headlines Depth',
          style: categories_heading_style,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: sh / 1.115,
                width: sw / 1,
                child: Stack(
                  children: [
                    // IMAGE

                    Positioned(
                      top: sw / 5,
                      child: SizedBox(
                        height: sh / 2.9,
                        width: sw / .99,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.image,
                          errorWidget: (context, url, error) => Icon(
                            Icons.error_outline,
                            size: 50,
                            color: Colors.red,
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                              child: Container(
                                height: sh / 2,
                                width: sw / 1.5,
                                color: Colors.white,
                              ),
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey.shade400),
                        ),
                      ),
                    ),

                    // CONTENT
                    Positioned(
                      top: sw / 1.15,
                      left: sw / 3000,
                      child: Container(
                        height: sh / 6.5,
                        width: sw / 1,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(sw / 20),
                                topRight: Radius.circular(sw / 20))),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: sw / 35),
                            child: AutoSizeText(
                              maxFontSize: 14,
                              minFontSize: 12,
                              '${widget.content ?? 'No Details'}',
                              style: location_news_content_depth_style,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // SOURCE & DATE
                    Positioned(
                      top: sw / .853,
                      left: sw / 3000,
                      child: Container(
                        height: sh / 18,
                        width: sw / 1,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: sw / 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Source: ${widget.source}',
                                style: selected_categories_choice_chip_style,
                              ),
                              Text(
                                widget.time,
                                style: selected_categories_choice_chip_style,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    // TITLE

                    Positioned(
                      top: sw / 16,
                      left: sw / 2500,
                      child: Container(
                        height: sh / 15,
                        width: sw / 1,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: sw / 35),
                            child: AutoSizeText(
                              maxFontSize: 14,
                              minFontSize: 10,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              widget.title,
                              style: location_news_title_depth_style,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                        top: sh / 1.45,
                        left: sw / 4,
                        child: Image.asset(
                            height: sh / 10,
                            width: sw / 2,
                            'assets/images/informer logo.png')),

                    Positioned(
                        top: sh / 1.26,
                        left: sw / 2.6,
                        child: Text(
                          'Informer',
                          style: infromer_heading_style,
                        )),

// HEADLINES HEADING

                    Positioned(
                      top: 0,
                      left: sw / 2500,
                      child: Container(
                        height: sh / 35,
                        width: sw / 1,
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: sw / 35),
                            child: AutoSizeText(
                              maxFontSize: 23,
                              minFontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              'H E A D L I N E S',
                              style: headline_style,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
