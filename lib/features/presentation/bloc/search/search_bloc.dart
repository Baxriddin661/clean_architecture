import 'package:clean_architecture/features/presentation/bloc/search/search_event.dart';
import 'package:clean_architecture/features/presentation/bloc/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/search_person.dart';

const SERVER_FAILURE_MESSAGE = "Server failure";
const CASHED_FAILURE_MESSAGE = "Cache failure";

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPersons;

  PersonSearchBloc({required this.searchPersons}) : super(PersonSearchEmpty()) {
    on<SearchPersonsEvent>(_onSearchPersons);
  }

  Future<void> _onSearchPersons(
    SearchPersonsEvent event,
    Emitter<PersonSearchState> emit,
  ) async {
    emit(PersonSearchLoading());

    final failureOrPerson = await searchPersons(
      SearchPersonParams(query: event.personQuery),
    );

    emit(
      failureOrPerson.fold(
        ((failure) =>
            PersonSearchError(message: _mapFailureToMessage(failure))),
        ((person) => PersonSearchLoaded(persons: person)),
      ),
    );


  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CASHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
