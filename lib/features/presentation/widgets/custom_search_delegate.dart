import 'package:clean_architecture/features/domain/entities/person_entity.dart';
import 'package:clean_architecture/features/domain/usecases/search_person.dart';
import 'package:clean_architecture/features/presentation/bloc/search/search_bloc.dart';
import 'package:clean_architecture/features/presentation/bloc/search/search_state.dart';
import 'package:clean_architecture/features/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search/search_event.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final _suggestions = ['Rick', 'Morty', 'Summer', 'Beth', 'Jerry'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Inside custom search delegate and search query is $query');

    BlocProvider.of<PersonSearchBloc>(
      context,
      listen: false,
    ).add(SearchPersonsEvent(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          Center(child: CircularProgressIndicator());
        } else if (state is PersonSearchLoaded) {
          final person = state.persons;
          if (person.isEmpty) {
            return _showErrorText("No Characters with that name found");
          }
          return ListView.builder(
            itemCount: person.isNotEmpty ? person.length : 0,
            itemBuilder: (context, index) {
              PersonEntity result = person[index];
              return SearchResult(personResult: result);
            },
          );
        } else if (state is PersonSearchError) {
          return _showErrorText(state.message);
        }
        return Center(child: Icon(Icons.now_wallpaper));
      },
    );
  }

  Widget _showErrorText(String text) {
    return Container(
      color: Colors.black,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _suggestions.length,
    );
  }
}
