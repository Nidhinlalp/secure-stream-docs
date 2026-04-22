part of 'viewer_cubit.dart';

sealed class ViewerState extends Equatable {
  const ViewerState();

  @override
  List<Object?> get props => [];
}

class ViewerInitial extends ViewerState {}

class ViewerLoading extends ViewerState {}

class ViewerLoaded extends ViewerState {
  final String path;
  final Document document;

  const ViewerLoaded({required this.path, required this.document});

  @override
  List<Object?> get props => [path, document];
}

class ViewerError extends ViewerState {
  final String message;

  const ViewerError(this.message);

  @override
  List<Object?> get props => [message];
}
