import 'package:github_app/repositories/data/repos_dto.dart';

import 'package:bloc/bloc.dart';
import 'package:github_app/repositories/data/repos_service.dart';

part 'repos_event.dart';
part 'repos_state.dart';

class RepositoriesBloc extends Bloc<RepoEvent, RepoListState> {

  @override
  RepoListState get initialState => RepoListEmptyState();

  @override
  Stream<RepoListState> mapEventToState(event) async* {
    if (event == RepoEvent.getRepos) {
      try {
        yield RepoListContentState(await fetchRepos());
      } catch (error) {
        yield RepoListErrorState();
      }
    }
  }
}