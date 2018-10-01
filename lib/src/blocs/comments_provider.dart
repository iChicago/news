import 'package:flutter/material.dart';
import 'comments_bloc.dart';
// When a class uses the provider, it will have to access the bloc
// so that's why we exported the bloc.
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc;

  CommentsProvider({Key key, Widget child})
      : bloc = CommentsBloc(),
        super (key: key, child: child);

  bool updateShouldNotify(_)=> true;

  static CommentsBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(CommentsProvider)
    as CommentsProvider).bloc;
  }

}