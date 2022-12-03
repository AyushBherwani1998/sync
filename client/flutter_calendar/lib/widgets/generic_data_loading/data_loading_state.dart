import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_loading_state.freezed.dart';

@freezed
abstract class DataLoadingState with _$DataLoadingState {
  const factory DataLoadingState.initial() = Initial;

  const factory DataLoadingState.loading() = Loading;

  const factory DataLoadingState.loaded() = Loaded;

  const factory DataLoadingState.error({required String error}) = Error;
}
