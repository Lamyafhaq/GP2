// This file defines the possible states for the UndertoneCubit,
// which is responsible for managing the process of saving undertone data.
// These states help the UI respond appropriately during loading, success, or failure.
part of 'undertone_cubit.dart';

@immutable
sealed class UndertoneState {}

final class UndertoneInitial extends UndertoneState {}

final class UndertoneSuccessed extends UndertoneState {}

final class UndertoneFailed extends UndertoneState {}
