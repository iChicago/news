import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../blocs/stories_bloc.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/news_refresh.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {

    // We will use 'of' method to navigate up the tree
    // to find the required bloc
    final bloc = StoriesProvider.of(context);

    // this is bad - DON't DO THIS
    bloc.fetchTopIds();

    return Scaffold(
        appBar: AppBar(
            title: Text('Top News'),
        ),
        body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc){
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context,AsyncSnapshot<List<int>> snapshot){

        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        // NewsRefresh indicator for manual refresh
        return NewsRefresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index){
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),
        );

      },
    );
  }
}
