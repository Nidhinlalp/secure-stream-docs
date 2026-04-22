part of 'highlight_cubit.dart';

sealed class HighlightState extends Equatable {
  const HighlightState();

  @override
  List<Object> get props => [];
}

/// Initial
class HighlightInitial extends HighlightState {}

/// Loading highlights
class HighlightLoading extends HighlightState {}

/// Loaded highlights
class HighlightLoaded extends HighlightState {
  final List<Highlight> highlights;

  const HighlightLoaded(this.highlights);

  @override
  List<Object> get props => [highlights];
}

/// Error
class HighlightError extends HighlightState {
  final String message;

  const HighlightError(this.message);

  @override
  List<Object> get props => [message];
}
