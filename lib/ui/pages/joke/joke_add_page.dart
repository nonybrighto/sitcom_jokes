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
import 'package:sitcom_joke/ui/widgets/buttons/general_buttons.dart';

class JokeAddPage extends StatefulWidget {
  final Movie selectedMovie;
  JokeAddPage({Key key, this.selectedMovie}) : super(key: key);

  @override
  _JokeAddPageState createState() => new _JokeAddPageState();
}

class _JokeAddPageState extends State<JokeAddPage>
    implements BlocDelegate<Joke> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  TextEditingController _movieController = TextEditingController();
  File _imageToUpload;
  Movie _selectedMovie;
  BuildContext _context;

  MovieService movieService = MovieService();
  JokeAddBloc jokeAddBloc;

  @override
  void initState() {
    super.initState();
    _selectedMovie = widget.selectedMovie;
    jokeAddBloc = JokeAddBloc(jokeService: JokeService(), delegate: this);

    _movieController.text =
        (_selectedMovie != null) ? _selectedMovie.title : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Joke'),
      ),
      body: Builder(builder: (context) {
        _context = context;
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Title'),
                        validator: (value){
                          if(value.trim().length < 3){
                            return 'Title should be more than 3 characters';
                          }
                        },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildMovieSelectionField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildTextJokeSpecificLayout(),
                  _buildImageJokeSpecificLayout(),
                  _buildJokeAddSubmitionButton()
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _buildJokeAddSubmitionButton() {
    return StreamBuilder<LoadState>(
      initialData: Loaded(),
      stream: jokeAddBloc.loadState,
      builder: (context, loadStateSnapShot) {
        LoadState loadState = loadStateSnapShot.data;

        return Hero(
          tag: 'joke_add',
                  child: RoundedButton(
              child: (loadState is Loading)
                  ? CircularProgressIndicator()
                  : Text(
                      'ADD JOKE',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: (loadState is Loading)
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
          if(_textController.text.isNotEmpty || _imageToUpload != null ){
            Joke jokeToAdd = Joke((b) => b
            ..id = 'id'
            ..title = _titleController.text
            ..text = _textController.text
            ..commentCount = 0
            ..likeCount = 0
            ..dateAdded = DateTime.now()
            ..liked = false
            ..favorited = false
            ..movie = _selectedMovie.toBuilder());
          jokeAddBloc.addJoke(jokeToAdd, _imageToUpload);
          }else{
             Scaffold.of(_context).showSnackBar(SnackBar(
                content: Text('Please add an image or a text'),
            ));
          }
      } else {
        Scaffold.of(_context).showSnackBar(SnackBar(
          content: Text('Please select a movie'),
        ));
      }
    }
  }

  _buildMovieSelectionField() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        onChanged: (value) {
          print(value);
        },
        decoration: InputDecoration(
          hintText: 'Movie',
          labelText: 'Movie',
        ),
        controller: this._movieController,
      ),
      suggestionsCallback: (String pattern) async {
        return await movieService.searchMovies(pattern);
      },
      itemBuilder: (context, movieSuggestion) {
        return ListTile(
          title: Text(movieSuggestion.title),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (movieSuggestion) {
        this._movieController.text = movieSuggestion.title;
        _selectedMovie = movieSuggestion;
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
          hintText: 'Joke Text\n\n\n',
          labelText: 'Joke Text'),
          validator: (value){
            if(value.trim().isNotEmpty &&  value.trim().length < 30){
              return 'Joke Should be more than 30 characters';
            }
          },
    );
  }

  _buildImageJokeSpecificLayout() {
    return Row(
      children: <Widget>[
         FlatButton(
           textColor: Theme.of(context).accentColor ,
          child: Row(
            children: <Widget>[
              Icon(Icons.image),
              Text('SELECT IMAGE',)
            ],
          ),
          onPressed: () {
            _getImageFromGallery();
          },
        ),
        SizedBox(
          width: 10,
        ),
        (_imageToUpload != null)?Container(
          height: 180.0,
          width: 180.0,
          decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(_imageToUpload))),
        ): Container(),
       
      ],
    );
  }

  _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageToUpload = image;
    });
  }

  @override
  error(String errorMessage) {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('Error while adding joke $errorMessage'),
    ));
    return null;
  }

  @override
  success(Joke t) async {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('Joke successfully added!!'),
    ));
    await Future.delayed(Duration(seconds: 2));
    //navigate to homepage
    Navigator.pop(context);
    return null;
  }
}
