import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(
        builder: (context){
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context){
          // extract the item id from settings.name
          // and pass ot onto newsDetail
          // Good place for data fetching and initialization
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(
              itemId: itemId,
          );
        },
      );
    }
  }
}


