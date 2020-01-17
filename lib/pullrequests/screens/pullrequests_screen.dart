import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/pullrequests/bloc/pullrequest_bloc.dart';
import 'package:github_app/pullrequests/data/pullrequests_dto.dart';

class GithubPullrequestList extends StatelessWidget {
  static final String router = '/pullrequests';

  @override
  Widget build(BuildContext context) {
    final String pullrequestUrl = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // Add 6 lines from here...
      appBar: AppBar(
        title: Text('Pullrequests'),
      ),
      body: Center(
        child: BlocProvider<PullrequestBloc>(
          create: (context) => PullrequestBloc()
            ..add(PullrequestEvent(pullrequestUrl)),
          child: _GithubPullrequestPage(),
        ),
      ),
    );
  }
}

class _GithubPullrequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullrequestBloc, PullrequestListState>(
      builder: (context, state) {
        return _getWidgetByState(state);
      },
    );
  }

  Widget _getWidgetByState(state) {
    if (state is PullrequestListContentState) {
      return ListView(children: _mapDTOToWidget(state.pullrequests));
    }

    if (state is PullrequestListEmptyState) {
      return CircularProgressIndicator();
    }

    if (state is PullrequestListNoContentState) {
      return Center(
        child: Text(
          "This repository has no open PRs",
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    return Center(
      child: Text((state as PullrequestListErrorState).errorMessage),
    );
  }

  List<Widget> _mapDTOToWidget(final List<Pullrequest> pulls) {
    return pulls.map((data) => _GithubPullrequestItemList(data)).toList();
  }
}

class _GithubPullrequestItemList extends StatelessWidget {
  final Pullrequest pullrequest;

  _GithubPullrequestItemList(this.pullrequest);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(pullrequest.owner.avatar),
        ),
        title: Text(pullrequest.title));
  }
}
