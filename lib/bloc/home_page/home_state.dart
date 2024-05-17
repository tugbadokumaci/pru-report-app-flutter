import '../../models/card_model.dart';
import '../../utils/resource.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Resource<List<CardModel>> cardResource;

  HomeSuccess({required this.cardResource});
}

class HomeError extends HomeState {}
