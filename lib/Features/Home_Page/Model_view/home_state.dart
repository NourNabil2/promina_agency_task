part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeGEtSuccess extends HomeState {}

final class UploadSuccess extends HomeState {}

final class UploadErorr extends HomeState {}

final class HomeGEtError extends HomeState {}


