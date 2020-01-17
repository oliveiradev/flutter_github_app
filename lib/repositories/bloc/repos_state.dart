part of 'repos_bloc.dart';

abstract class RepoListState {

  List<Repo> get items => [];
}

class RepoListEmptyState extends RepoListState {}

class RepoListErrorState extends RepoListState {
  final String errorMessage = "Something goes wrong";
}

class RepoListContentState extends RepoListState {
  final List<Repo> repos;

  RepoListContentState(this.repos);

  @override
  List<Repo> get items => repos;
}