import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/repositories/bloc/repos_bloc.dart';
import 'package:github_app/repositories/data/repos_dto.dart';
import 'package:github_app/shared/router.dart';

class GithubRepoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RepositoriesBloc>(
      create: (context) => RepositoriesBloc()..add(RepoEvent.getRepos),
      child: _GithubReposPage(),
    );
  }
}

class _GithubReposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoriesBloc, RepoListState>(
      builder: (context, state) {
        return _getWidgetByState(state);
      },
    );
  }

  Widget _getWidgetByState(state) {
    if (state is RepoListContentState) {
      return SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: mapDTOToWidget(state.repos),
        ),
      );
    }

    if (state is RepoListEmptyState) {
      return CircularProgressIndicator();
    }

    return Center(
      child: Text((state as RepoListErrorState).errorMessage),
    );
  }

  List<Widget> mapDTOToWidget(List<Repo> _repo) {
    return _repo.map((item) => _GithubRepoItemList(item)).toList();
  }
}

class _GithubRepoItemList extends StatelessWidget {
  final Repo repo;

  const _GithubRepoItemList(this.repo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(repo.owner.avatar)),
      title: Text(repo.name),
      subtitle: Text(repo.description),
      onTap: () {
        Router.navigateTo(context, '/pullrequests', arguments: repo.pulls);
      },
    );
  }
}
