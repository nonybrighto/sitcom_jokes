import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/joke_add_bloc.dart';
import 'package:sitcom_joke/models/bloc_delegate.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/services/movie_service.dart';

class JokeAddPage extends StatefulWidget {
  final JokeType jokeType;
  final Movie selectedMovie;
  JokeAddPage({Key key, this.jokeType, this.selectedMovie}) : super(key: key);

  @override
  _JokeAddPageState createState() => new _JokeAddPageState();
}

class _JokeAddPageState extends State<JokeAddPage>  implements BlocDelegate<Joke>{
  JokeType jokeType;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController =  TextEditingController();
  TextEditingController _textController =  TextEditingController();
  TextEditingController _movieController =  TextEditingController();
  File _imageToUpload;
  Movie _selectedMovie;
  BuildContext _context;

  MovieService movieService = MovieService();
  JokeAddBloc jokeAddBloc;

  @override
  void initState() {
    super.initState();
    jokeType = widget.jokeType;
    _selectedMovie =widget.selectedMovie;
    jokeAddBloc =  JokeAddBloc(jokeService: JokeService(), delegate: this);
   
    _movieController.text = (_selectedMovie != null)? _selectedMovie.basicDetails.name: '';
  }

  @override
  Widget build(BuildContext context) {
    String addTypeString = (jokeType == JokeType.image) ? 'Image' : 'Text';
    return Scaffold(
      appBar: AppBar(
        title: Text('Add $addTypeString Joke'),
        actions: <Widget>[_buildTypeSwapIconButton()],
      ),
      body: Builder(builder:(context){
            _context =context;
            return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: 'Title',
                    hintText: 'Title'),
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildMovieSelectionField(),
              SizedBox(
                height: 10.0,
              ),
              (jokeType == JokeType.image)
                  ? _buildImageJokeSpecificLayout()
                  : _buildTextJokeSpecificLayout(),

              _buildJokeAddSubmitionButton()
            ],
          ),
        ),
      );

      }),
    );
  }


  _buildJokeAddSubmitionButton(){

     return StreamBuilder<LoadState>(
                            initialData: Loaded(),
                            stream: jokeAddBloc.loadState,
                            builder: (context, loadStateSnapShot) {
                              LoadState loadState =
                                  loadStateSnapShot.data;

                              return SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  color: const Color(0Xfffe0e4f),
                                  child: (loadState is Loading)
                                      ? CircularProgressIndicator()
                                      : Text(
                                          'ADD JOKE',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                  onPressed:
                                      (loadState is Loading)
                                          ? null
                                          : () {
                                              _submitJoke();
                                            },
                                ),
                              );
                            },
                          );
    
  }

   _submitJoke() {
    if (_formKey.currentState.validate()) {
      if (_selectedMovie != null) {
        if ((jokeType == JokeType.image && _imageToUpload != null) || jokeType ==JokeType.text) {

              Joke jokeToAdd = Joke((b) => b
                ..id = 'id'
                ..title = _titleController.text
                ..content = (jokeType ==JokeType.text)? _textController.text: ''
                ..totalComments = 0
                ..likes = 0
                ..dateAdded = DateTime.now()
                ..jokeType = jokeType
                ..movie = _selectedMovie.basicDetails.toBuilder()
                );
              jokeAddBloc.addJoke(jokeToAdd, _imageToUpload);
        } else {
          Scaffold.of(_context).showSnackBar(SnackBar(
              content: Text('Please select an image to upload'),
            ));
        }
      } else {
        Scaffold.of(_context).showSnackBar(SnackBar(
          content: Text('Please select a movie'),
        ));
      }
    }
  }

   _buildMovieSelectionField(){

    return  TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Movie',
                                labelText: 'Movie',
                                filled: true,
                                fillColor: Colors.black12,
                              ),
                              controller: this._movieController,
                            ),
                            suggestionsCallback: (String pattern)async {
                                return await movieService.searchMovies(pattern);
                            },
                            itemBuilder: (context, movieSuggestion) {
                              return ListTile(
                                title: Text(movieSuggestion.basicDetails.username),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (movieSuggestion) {
                              this._movieController.text = movieSuggestion.basicDetails.username;
                              _selectedMovie =  movieSuggestion;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please select a Movie';
                              }
                            },
                          );
  }

  

  _buildTextJokeSpecificLayout() {
    return TextFormField(
      maxLines: null,
      controller: _textController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Text Joke\n\n\n',
          labelText: 'Text Joke'),
    );
  }

  _buildImageJokeSpecificLayout() {
    return Column(
      children: <Widget>[
        Container(
          height: 180.0,
          width: 180.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: (_imageToUpload != null)
                      ? FileImage(_imageToUpload)
                      : AssetImage('assets/images/add_image_place_holder.jpg'))),
        ),
        RaisedButton(
          child: Text(
            'SELECT IMAGE',
            style: TextStyle(color: Colors.white),
          ),
          color: const Color(0Xfffe0e4f),
          onPressed: () {
            _getImageFromGallery();
          },
        )
      ],
    );
  }

  _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageToUpload = image;
    });
  }

  _buildTypeSwapIconButton() {
    return IconButton(
      icon: Icon(
          (jokeType == JokeType.image) ? Icons.ac_unit : Icons.access_alarm),
      onPressed: () {
        setState(() {
          jokeType =
              (jokeType == JokeType.image) ? JokeType.text : JokeType.image;
        });
      },
    );
  }

  @override
  error(String errorMessage) {
    Scaffold.of(_context).showSnackBar(SnackBar(
              content: Text('Error while adding joke $errorMessage'),
    ));
    return null;
  }

  @override
  success(Joke t) async{
    Scaffold.of(_context).showSnackBar(SnackBar(
              content: Text('Joke successfully added!!'),
    ));
    await Future.delayed(Duration(seconds: 2));
    //navigate to homepage
    Navigator.pop(context);
    return null;
  }
}
