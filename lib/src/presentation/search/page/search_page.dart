import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_news/app/theme.dart';
import 'package:latest_news/core/utils/status.dart';
import 'package:latest_news/core/widgets/error_widget.dart';
import 'package:latest_news/src/presentation/home/bloc/home_bloc.dart';
import 'package:latest_news/src/presentation/home/bloc/home_event.dart';
import 'package:latest_news/src/presentation/home/bloc/home_state.dart';
import 'package:latest_news/src/presentation/home/widget/build_news_card.dart';
import 'package:latest_news/src/presentation/news/widgets/loading_widget.dart';

import '../../../../core/constants/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Headline News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.background,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyColors.primary,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  width: .9,
                  color: Colors.grey
              ),
            ),
            child: TextField(
              onTapOutside: (tab) => FocusScope.of(context).unfocus(),
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search',
                border: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onChanged: (value) {
                setState(() {}); // Trigger rebuild when the search term changes
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status == Status.success) {
                  var allNews = state.allNews;

                  var filteredNews = _searchController.text.isEmpty
                      ? [] // Show nothing if no search term
                      : allNews?.where((item) {
                          return item.articleTitle?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false;
                        }).toList();

                  var uniqueNews = <dynamic>{};
                  filteredNews = filteredNews
                      ?.where(
                        (item) => uniqueNews.add(
                          item?.articleTitle,
                        ),
                      )
                      .toList();

                  if (filteredNews == null || filteredNews.isEmpty) {
                    return const Center(
                      child: Text('No results found.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredNews.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = filteredNews?[index];
                    //  Color cardColor = index % 2 == 0 ? Colors.red.withOpacity(0.6) : Colors.orangeAccent.shade200.withOpacity(0.6);
                      Color cardColor = index % 2 == 0 ? Colors.yellow.shade100 : Colors.greenAccent.shade100;
                      //Color cardColor = index % 2 == 0 ? Colors.lightGreenAccent.shade100 : Colors.grey.shade200;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: .9,
                                    color: Colors.grey
                                ),
                              ),
                              child: NewsCard(
                                news: item,
                              ),
                            ),
                          ),
                          //const Divider(),
                        ],
                      );
                    },
                  );
                } else if (state.status == Status.error) {
                  return SizedBox(
                    height: 500,
                    child: MyErrorWidget(
                      onRetry: () {
                        context.read<HomeBloc>().add(const GetScienceNews(link: Constants.businessNewsLink));
                        context.read<HomeBloc>().add(const GetScienceNews(link: Constants.worldNewsLink));
                        context.read<HomeBloc>().add(const GetScienceNews(link: Constants.generalNewsLink));
                        context.read<HomeBloc>().add(const GetScienceNews(link: Constants.sportsNewsLink));
                        context.read<HomeBloc>().add(const GetScienceNews(link: Constants.scienceNewsLink));
                      },
                      errorMsg: state.failure?.errorMsg ?? "",
                    ),
                  );
                }
                return const LoadingWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
