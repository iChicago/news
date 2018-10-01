import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../modules/item_module.dart';
import 'dart:async';

class NewsDetail extends StatelessWidget {

  final int itemId;
  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }


  Widget buildBody(CommentsBloc bloc){
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context,AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot){

        if(!snapshot.hasData){
          return Text('snapshot Loading....');
        }

        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context,AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData){
              return Text('itemSnapshot Loading...');
            }

            return buildTitle(itemSnapshot.data);
          },
        );

      },
    );
  }

  Widget buildTitle(ItemModel item){
    return Text('${item.title}');
  }
}
