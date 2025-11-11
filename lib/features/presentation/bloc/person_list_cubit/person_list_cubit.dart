import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/domain/entities/person_entity.dart';
import 'package:clean_architecture/features/domain/usecases/get_all_persons.dart';
import 'package:clean_architecture/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const SERVER_FAILURE_MESSAGE = "Server failure";
const CASHED_FAILURE_MESSAGE = "Cache failure";

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());
  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) return;
    final currentState = state;

    var oldPersons = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPersons = currentState.personsList;
    }

    emit(PersonLoading(oldPersons, isFirstFetch: page == 1));

    final failureOrPersons = await getAllPersons(PagePersonParams(page: page));
    failureOrPersons.fold(
      (error) => emit(PersonError(message: _mapFailureToMessage(error))),
      (character) {
        page++;
        final persons = (state as PersonLoading).oldPersonsList;
        persons.addAll(character);
        emit(PersonLoaded(persons));
      },
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
