import 'package:bloc/bloc.dart';
import 'package:github_app/pullrequests/data/pullrequests_dto.dart';
import 'package:github_app/pullrequests/data/pullrequests_service.dart';

part 'pullrequest_event.dart';
part 'pullrequest_state.dart';

class PullrequestBloc extends Bloc<PullrequestEvent, PullrequestListState> {
  @override
  PullrequestListState get initialState => PullrequestListEmptyState();

  @override
  Stream<PullrequestListState> mapEventToState(PullrequestEvent event) async* {
    try {
      final items = await fetchPulls(sanitizePullsUrl(event.prUrl));
      yield items.isNotEmpty
          ? PullrequestListContentState(items)
          : PullrequestListNoContentState();
    } catch (error) {
      yield PullrequestListErrorState();
    }
  }

  String sanitizePullsUrl(final String url) {
    return url.replaceAll("{/number}", "");
  }
}
