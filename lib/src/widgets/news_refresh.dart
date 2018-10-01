import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class NewsRefresh extends StatelessWidget {

  final Widget child;
  NewsRefresh({this.child});

  @override
  Widget build(BuildContext context) {

    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
        child: child,
        onRefresh: () async{
          await bloc.clearCache();
          await bloc.fetchTopIds();
        },
    );
  }
}
