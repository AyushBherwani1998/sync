import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_loading_state.dart';

const _defaultFadeDuration = Duration(milliseconds: 200);

class _DefaultProgressLoader extends StatelessWidget {
  const _DefaultProgressLoader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? const CircularProgressIndicator()
          : const CupertinoActivityIndicator(),
    );
  }
}

typedef OnError = Widget Function(String errorMessage);

class GenericDataLoader extends StatelessWidget {
  final Duration fadeDuration;
  final Widget initial;
  final Widget onLoaded;
  final OnError onError;
  final Widget onLoading;
  final Stream<DataLoadingState> dataLoadingStateStream;

  const GenericDataLoader({
    Key? key,
    required this.onLoaded,
    required this.onError,
    required this.dataLoadingStateStream,
    this.initial = const Offstage(),
    this.fadeDuration = _defaultFadeDuration,
    this.onLoading = const _DefaultProgressLoader(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataLoadingState>(
      initialData: const DataLoadingState.initial(),
      stream: dataLoadingStateStream,
      builder: (context, snapshot) => AnimatedSwitcher(
        duration: fadeDuration,
        child: snapshot.data?.when(
          initial: () => initial,
          loading: () => onLoading,
          loaded: () => onLoaded,
          error: onError,
        ),
      ),
    );
  }
}
