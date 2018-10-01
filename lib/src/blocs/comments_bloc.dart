import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../modules/item_module.dart';
import '../resources/repository.dart';

class CommentsBloc {

  final _repository = Repository();

  // Stream Controllers
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // Stream Getters
  Observable<Map<int,Future<ItemModel>>> get itemWithComments =>
  _commentsOutput.stream;

  // Sink Getters
  Function(int) get fetchItemWithComments =>
  _commentsFetcher.sink.add;


  CommentsBloc(){
    _commentsFetcher.stream.transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }


  // internal cache
  // ScanStreamTransformer will have "int" input and "map" output
  _commentsTransformer(){
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
    (cache, int id, index){
      print('[Comments request] $index');
      //recursive fetch
      cache[id] = _repository.fetchItem(id);
      cache[id].then((ItemModel item){
        item.kids.forEach((kidId) => fetchItemWithComments(kidId));
      });
      return cache;
    },
    <int, Future<ItemModel>>{}
    );
  }


  dispose(){
    _commentsFetcher.close();
    _commentsOutput.close();
  }


}