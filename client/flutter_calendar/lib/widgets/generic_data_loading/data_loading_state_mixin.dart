import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'data_loading_state.dart';

mixin DataLoadingStateMixin {
  final BehaviorSubject<DataLoadingState> _subjectDataLoadingState =
      BehaviorSubject<DataLoadingState>();

  ValueStream<DataLoadingState> get dataLoadingState =>
      _subjectDataLoadingState.stream;

  DataLoadingState get currentState => _subjectDataLoadingState.value;

  void setStateInitial() =>
      _subjectDataLoadingState.add(const DataLoadingState.initial());

  void setStateLoading() =>
      _subjectDataLoadingState.add(const DataLoadingState.loading());

  void setStateLoaded() =>
      _subjectDataLoadingState.add(const DataLoadingState.loaded());

  void setStateError([String? errorMessage]) =>
      _subjectDataLoadingState.add(DataLoadingState.error(
        error: errorMessage ?? 'Some error occured, Please try again.',
      ));

  @protected
  void disposeDataLoadingStateMixin() {
    _subjectDataLoadingState.close();
  }
}
