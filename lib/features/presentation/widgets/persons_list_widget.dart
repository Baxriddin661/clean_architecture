import 'dart:async';

import 'package:clean_architecture/features/domain/entities/person_entity.dart';
import 'package:clean_architecture/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:clean_architecture/features/presentation/widgets/person_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsList extends StatelessWidget {
  final scrollController = ScrollController();

  PersonsList({super.key});

  // const PersonsList({super.key});
  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        setupScrollController(context);
        List<PersonEntity> persons = [];
        bool isLoading = false;
        if (state is PersonLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoading) {
          persons = state.oldPersonsList;
          isLoading = true;
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        } else if (state is PersonError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemCount: persons.length + (isLoading ? 1 : 0),
          separatorBuilder: (context, index) =>
              Divider(color: Colors.transparent),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              Timer(Duration(microseconds: 30), (){
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
