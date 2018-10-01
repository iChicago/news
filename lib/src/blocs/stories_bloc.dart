import 'package:rxdart/rxdart.dart';
import '../modules/item_module.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc{

  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int,Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();


  // Getters to Streams - to be available for outside world
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;


  StoriesBloc(){
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }


  // Here the source of input is different, it is not a Widget, so
  // we will not set getter for it. The source of input is the repository.
  fetchTopIds() async{
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }


  clearCache(){
    return _repository.clearCache();
  }


  _itemsTransformer(){
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>>cache, int id, index){
        print('[Story request] $index');
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose(){
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }

}