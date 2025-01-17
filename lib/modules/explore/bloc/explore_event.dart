part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class DataRequested extends ExploreEvent {
  const DataRequested({
    required this.user,
  });
  final User user;

  @override
  List<Object> get props => [user];
}
