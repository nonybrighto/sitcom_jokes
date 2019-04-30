import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/bloc_delegate.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/services/joke_service.dart';

class JokeAddBloc extends BlocBase{
 
  
  final JokeService jokeService;
  final BlocDelegate<Joke> delegate;
  
  final _loadStateController = BehaviorSubject<LoadState>();
  final _addJokeController =BehaviorSubject<Map>();


  Stream<LoadState> get loadState => _loadStateController.stream;

  void Function(Map<String, dynamic>) get addJoke => (jokeUploadDetails) => _addJokeController.sink.add(jokeUploadDetails);
 
  JokeAddBloc({this.jokeService, this.delegate}){

    _loadStateController.sink.add(Loaded());

        _addJokeController.stream.listen((jokeUploadDetails) async{
            try{
                _loadStateController.sink.add(Loading());
                await  jokeService.addJoke(jokeUploadDetails: jokeUploadDetails);
                _loadStateController.sink.add(Loaded());
                delegate.success(null);
            }catch(err){
                String errorMessage = err.toString();
                delegate.error(errorMessage);
                _loadStateController.sink.add(LoadError(errorMessage));
            }
        });

  }
 
 
  @override
  void dispose() {
    _loadStateController.close();
    _addJokeController.close();
  }

}