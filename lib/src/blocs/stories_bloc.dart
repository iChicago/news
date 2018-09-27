import 'package:rxdart/rxdart.dart';
import '../modules/item_module.dart';
import '../resources/repository.dart';

class StoriesBloc{

  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  // Getters to Streams - to be available for outside world
  Observable<List<int>> get topIds => _topIds.stream;

  // Here the source of input is different, it is not a Widget, so
  // we will not set getter for it. The source of input is the repository.
  fetchTopIds() async{
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose(){
    _topIds.close();
  }

}