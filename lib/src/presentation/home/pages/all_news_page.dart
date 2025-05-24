import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:latest_news/core/constants/constants.dart';
import 'package:latest_news/core/utils/status.dart';
import 'package:latest_news/core/widgets/error_widget.dart';
import 'package:latest_news/src/presentation/home/bloc/home_bloc.dart';
import 'package:latest_news/src/presentation/home/bloc/home_event.dart';
import 'package:latest_news/src/presentation/home/bloc/home_state.dart';
import 'package:latest_news/src/presentation/home/widget/build_news_card.dart';
import 'package:latest_news/src/presentation/news/widgets/loading_widget.dart';

import '../../../../app/theme.dart';

class AllNewsPage extends StatefulWidget {
  const AllNewsPage({super.key});

  @override
  State<AllNewsPage> createState() => _AllNewsPageState();
}

class _AllNewsPageState extends State<AllNewsPage> {
  Future<void> _refreshNews() async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<HomeBloc>().add(const GetAllNews(link: Constants.allNewsLink));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          var allNews = state.allNews;
          return LiquidPullToRefresh(
            color: Colors.grey.withOpacity(0.2),
            backgroundColor: MyColors.primary,
            animSpeedFactor: 2,
            springAnimationDurationInMilliseconds: 600,
            showChildOpacityTransition: false,
            height: 100,
            onRefresh: _refreshNews,
            child: ListView.builder(
              itemCount: allNews?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var item = allNews?[index];
              //  Color cardColor = index % 2 == 0 ? Colors.red.withOpacity(0.6) : Colors.orangeAccent.shade200.withOpacity(0.6);
                Color cardColor = index % 2 == 0 ? Colors.yellow.shade100 : Colors.greenAccent.shade100;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: NewsCard(
                          news: item,
                        ),
                      ),
                    ),
                  //  const Divider(),
                  ],
                );
              },
            ),
          );
        } else if (state.status == Status.error) {
          return SizedBox(
            height: 500,
            child: MyErrorWidget(
              onRetry: () {
                context.read<HomeBloc>().add(const GetAllNews(link: Constants.allNewsLink));
              },
              errorMsg: state.failure?.errorMsg ?? "",
            ),
          );
        }
        return const LoadingWidget();
      },
    );
  }


}
