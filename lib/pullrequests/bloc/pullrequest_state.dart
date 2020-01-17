part of 'pullrequest_bloc.dart';

abstract class PullrequestListState {
  List<Pullrequest> get items => [];
}

class PullrequestListEmptyState extends PullrequestListState {}

class PullrequestListErrorState extends PullrequestListState {
  final String errorMessage = "Something goes wrong";
}

class PullrequestListNoContentState extends PullrequestListState {}

class PullrequestListContentState extends PullrequestListState {
  final List<Pullrequest> pullrequests;

  PullrequestListContentState(this.pullrequests);

  @override
  List<Pullrequest> get items => pullrequests;
}
