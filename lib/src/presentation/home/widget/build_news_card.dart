import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:latest_news/app/router.dart';
import 'package:latest_news/src/presentation/bookmark/data/model/bookmark_news_model.dart';
import 'package:share_and_open_url/share_and_open_url.dart';
import 'package:shimmer/shimmer.dart';
import 'package:latest_news/src/presentation/home/data/model/news_model.dart';
import 'package:latest_news/src/presentation/bookmark/data/bookmark_hive_service.dart';

class NewsCard extends StatefulWidget {
  final NewsModel? news;

  const NewsCard({super.key, required this.news});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isBookmarked = false;
  final HiveService _hiveService = HiveService();
  final ShareAndOpenUrl _shareAndOpenUrlPlugin = ShareAndOpenUrl();

  @override
  void initState() {
    super.initState();
    _checkIfBookmarked();
  }

  Future<void> _toggleBookmark() async {
    if (_isBookmarked) {
      await _hiveService.deleteBookmark(widget.news?.articleUrl ?? "");
      setState(() {
        _isBookmarked = false;
      });
    } else {
      List<BookmarkNewsModel> bookmarks = await _hiveService.getBookmarks();
      if (bookmarks.any((bookmark) => bookmark.articleUrl == widget.news?.articleUrl)) {
        return;
      }
      await _hiveService.addBookmark(widget.news!);
      setState(() {
        _isBookmarked = true;
      });
    }
  }

  Future<void> _checkIfBookmarked() async {
    List<BookmarkNewsModel> bookmarks = await _hiveService.getBookmarks();
    setState(() {
      _isBookmarked = bookmarks.any((bookmark) => bookmark.articleUrl == widget.news?.articleUrl);
    });
  }

  Future<void> _shareText(String url) async {
    try {
      await _shareAndOpenUrlPlugin.shareText(url);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: "Failed to share text: '${e.message}'.");
    }
  }

  // void _launchURL(String url) async {
  //   await EasyLauncher.url(
  //       url: url,
  //       mode: Mode.inAppWeb,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<BookmarkNewsModel>>(
      valueListenable: Hive.box<BookmarkNewsModel>('bookmarks').listenable(),
      builder: (context, box, _) {
        _isBookmarked = box.values.any((bookmark) => bookmark.articleUrl == widget.news?.articleUrl);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListView(
            shrinkWrap: true, // Shrinks the listview to its child content
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside the ListView if it's inside a scrollable parent
            children: [
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(Routes.productPage, extra: widget.news?.articleUrl ?? "");
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.news?.ImageURL != null
                    ? SizedBox(
                      height: 100,
                      width: 130,
                      child: Container( // Wrap ClipRRect with Container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), // Keep the same border radius
                          border: Border.all(
                            color: Colors.grey, // Choose your border color
                            width: .5,         // Choose your border width
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: widget.news?.ImageURL ?? "",
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 140,
                                width: 180,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(height: 140, width: 180, color: Colors.white),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                        // ? SizedBox(
                        //     height: 110,
                        //     width: 140,
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(12),
                        //       child: CachedNetworkImage(
                        //         imageUrl: widget.news?.ImageURL ?? "",
                        //         placeholder: (context, url) => Shimmer.fromColors(
                        //           baseColor: Colors.grey[300]!,
                        //           highlightColor: Colors.grey[100]!,
                        //           child: Container(
                        //             height: 140,
                        //             width: 180,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //         errorWidget: (context, url, error) => Shimmer.fromColors(
                        //           baseColor: Colors.grey[300]!,
                        //           highlightColor: Colors.grey[100]!,
                        //           child: Container(height: 140, width: 180, color: Colors.white),
                        //         ),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   )
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const SizedBox(height: 10),
                          Text(
                            widget.news?.articleTitle ?? "",
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (widget.news?.articleAuthor?.isNotEmpty == true)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                widget.news?.articleAuthor ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          if (widget.news?.publisher?.isNotEmpty == true)
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                widget.news?.publisher ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                              //  widget.news?.articleSection ?? "",
                                widget.news?.displaySection ?? "",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                formatTimestamp(widget.news?.timeStamp ?? DateTime.now()),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: 50,
                                child: PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_horiz),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                  onSelected: (String result) async {
                                    if (result == 'Bookmark') {
                                      await _toggleBookmark();
                                    } else if (result == 'Share') {
                                      if (widget.news?.articleUrl != null && (widget.news?.articleUrl ?? "").isNotEmpty) {
                                        _shareText(widget.news?.articleUrl ?? "");
                                      }
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    const PopupMenuItem<String>(
                                      value: 'Share',
                                      child: ListTile(
                                        leading: Icon(Icons.ios_share, color: Colors.black),
                                        title: Text('Share', style: TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                    const PopupMenuDivider(),
                                    PopupMenuItem<String>(
                                      value: 'Bookmark',
                                      child: ListTile(
                                        leading: Icon(
                                          _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                                          color: _isBookmarked ? Colors.blue : Colors.grey,
                                        ),
                                        title: const Text('Bookmark', style: TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  String formatTimestamp(DateTime dateTime) {
    DateTime now = DateTime.now();
    final localTime = dateTime.toLocal();

    if (now.year == localTime.year && now.month == localTime.month && now.day == localTime.day) {
      final difference = now.difference(localTime);
      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inHours == 1) {
        return '1 hour ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      }
    }
    return DateFormat('EE MMM-dd').format(localTime);
  }


  // String formatTimestamp(DateTime dateTime) {
  //   DateTime now = DateTime.now();
  //   final localTime = dateTime.toLocal();
  //
  //   //if (now.year == dateTime.year && now.month == dateTime.month && now.day == dateTime.day) {
  //   if (now.year == localTime.year && now.month == localTime.month && now.day == localTime.day) {
  //     Duration difference = now.difference(dateTime);
  //     if (difference.inMinutes == 1) {
  //       return '1 minute ago';
  //     } else if (difference.inMinutes < 60) {
  //       return '${difference.inMinutes} minutes ago';
  //     } else if (difference.inHours == 1) {
  //       return '1 hour ago';
  //     } else {
  //       return '${difference.inHours} hours ago';
  //     }
  //   } else {
  //     return DateFormat('EE MMM-dd yyyy').format(dateTime);
  //   }
  // }
}
