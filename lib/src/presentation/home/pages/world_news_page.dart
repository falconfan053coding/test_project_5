import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:latest_news/core/utils/status.dart';
import 'package:latest_news/core/widgets/error_widget.dart';
import 'package:latest_news/src/presentation/home/bloc/home_bloc.dart';
import 'package:latest_news/src/presentation/home/bloc/home_event.dart';
import 'package:latest_news/src/presentation/home/bloc/home_state.dart';
import 'package:latest_news/src/presentation/home/widget/build_news_card.dart';
import 'package:latest_news/src/presentation/news/widgets/loading_widget.dart';

import '../../../../app/theme.dart';
import '../../../../core/constants/constants.dart';

class WorldNewsPage extends StatefulWidget {
  const WorldNewsPage({super.key});

  @override
  State<WorldNewsPage> createState() => _WorldNewsPageState();
}

class _WorldNewsPageState extends State<WorldNewsPage> {

  Future<void> _refreshNews() async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<HomeBloc>().add(const GetWorldNews(link: Constants.worldNewsLink));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.worldNewsStatus == Status.success) {
          var news = state.worldNews;
          return LiquidPullToRefresh(
            color: Colors.grey.shade50,
            backgroundColor: MyColors.primary,
            animSpeedFactor: 2,
            springAnimationDurationInMilliseconds: 600,
            showChildOpacityTransition: false,
            height: 100,
            onRefresh: _refreshNews,
            child: ListView.builder(
              itemCount: news?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var item = news?[index];
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
                //    const Divider(),
                  ],
                );
              },
            ),
          );
        } else if (state.worldNewsStatus == Status.error) {
          return SizedBox(
            height: 500,
            child: MyErrorWidget(
              onRetry: () {
                context.read<HomeBloc>().add(const GetSportsNews(link: Constants.worldNewsLink));
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
