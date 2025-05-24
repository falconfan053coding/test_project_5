import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:latest_news/app/theme.dart';
import 'package:latest_news/core/utils/status.dart';
import 'package:latest_news/core/widgets/error_widget.dart';
import 'package:latest_news/src/presentation/home/bloc/home_bloc.dart';
import 'package:latest_news/src/presentation/home/bloc/home_event.dart';
import 'package:latest_news/src/presentation/home/bloc/home_state.dart';
import 'package:latest_news/src/presentation/home/widget/build_news_card.dart';
import 'package:latest_news/src/presentation/news/widgets/loading_widget.dart';

import '../../../../core/constants/constants.dart';

class GeneralNewsPage extends StatefulWidget {
  const GeneralNewsPage({super.key});

  @override
  State<GeneralNewsPage> createState() => _GeneralNewsPageState();
}

class _GeneralNewsPageState extends State<GeneralNewsPage> {
  Future<void> _refreshNews() async {
    await Future.delayed(const Duration(seconds: 1));
    BlocProvider.of<HomeBloc>(context).add(const GetGeneralNews(link: Constants.generalNewsLink));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.generalNewsStatus == Status.success) {
          var news = state.generalNews;
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
                  //  const Divider(),
                  ],
                );
              },
            ),
          );
        } else if (state.generalNewsStatus == Status.error) {
          return SizedBox(
            height: 500,
            child: MyErrorWidget(
              onRetry: () {
                context.read<HomeBloc>().add(const GetSportsNews(link: Constants.generalNewsLink));
              },
              errorMsg: state.failure?.errorMsg ?? "",
            ),
          );
        }
        return const LoadingWidget();
      },
    );
  }

  String formatTimestamp(DateTime dateTime) {
    DateTime now = DateTime.now();

    // Check if the news item was published today
    if (now.year == dateTime.year && now.month == dateTime.month && now.day == dateTime.day) {
      // Calculate difference in time
      Duration difference = now.difference(dateTime);
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago'; // Show minutes if published within the last hour
      } else {
        return '${difference.inHours} hours ago'; // Show hours if published today but not in the last hour
      }
    } else {
      // Return formatted date if not today
      return DateFormat('MM/dd/yy').format(dateTime);
    }
  }
}
