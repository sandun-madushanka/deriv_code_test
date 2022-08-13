part of 'binary_cubit.dart';

@immutable
abstract class BinaryState {}

class BinaryInitial extends BinaryState {}

class BinaryShowLoading extends BinaryState {}

class BinaryHideLoading extends BinaryState {}

class BinaryDataSymbol extends BinaryState {
  final List<SymbolValue> symbol;
  BinaryDataSymbol(this.symbol);
}

class BinaryDataTicks extends BinaryState {
  final Tick tick;
  BinaryDataTicks(this.tick);
}
