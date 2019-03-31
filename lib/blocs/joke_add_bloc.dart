import 'dart:io';

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

  void Function(Joke, File) get addJoke => (joke, imageToUpload) => _addJokeController.sink.add({'joke': joke, 'imageToUpload':imageToUpload});
 
  JokeAddBloc({this.jokeService, this.delegate}){

    _loadStateController.sink.add(Loaded());

        _addJokeController.stream.listen((uploadDetails) async{
            try{
                _loadStateController.sink.add(Loading());
                await  jokeService.addJoke(joke:uploadDetails['joke'], imageToUpload:uploadDetails['imageToUpload']);
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