// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailsViewModel on _DetailsViewModel, Store {
  Computed<int>? _$totalEditCountComputed;

  @override
  int get totalEditCount =>
      (_$totalEditCountComputed ??= Computed<int>(() => super.totalEditCount,
              name: '_DetailsViewModel.totalEditCount'))
          .value;
  Computed<int>? _$totalCharactersComputed;

  @override
  int get totalCharacters =>
      (_$totalCharactersComputed ??= Computed<int>(() => super.totalCharacters,
              name: '_DetailsViewModel.totalCharacters'))
          .value;
  Computed<int>? _$letterCountComputed;

  @override
  int get letterCount =>
      (_$letterCountComputed ??= Computed<int>(() => super.letterCount,
              name: '_DetailsViewModel.letterCount'))
          .value;
  Computed<int>? _$numberCountComputed;

  @override
  int get numberCount =>
      (_$numberCountComputed ??= Computed<int>(() => super.numberCount,
              name: '_DetailsViewModel.numberCount'))
          .value;

  @override
  String toString() {
    return '''
totalEditCount: ${totalEditCount},
totalCharacters: ${totalCharacters},
letterCount: ${letterCount},
numberCount: ${numberCount}
    ''';
  }
}
