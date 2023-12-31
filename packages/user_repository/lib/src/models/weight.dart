import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/weight_entity.dart';

/// A class representing weight information with various attributes.
// ignore: must_be_immutable
class Weight extends Equatable {
  String id;
  final String weight;
  final DateTime date;

  /// Creates a new instance of [Weight] with the provided values.
  Weight({
    required this.id,
    required this.weight,
    required this.date,
  });

  /// An empty weight entry, which represents an uninitialized or empty weight record.
  static final empty = Weight(
    id: '',
    weight: '',
    date: DateTime.now(),
  );

  /// Modifies the parameters of the current [Weight] instance and returns a new instance.
  Weight copyWith({
    String? id,
    String? weight,
    DateTime? date,
  }) {
    return Weight(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  /// Convenience getter to determine whether the current weight entry is empty.
  bool get isEmpty => this == Weight.empty;

  /// Convenience getter to determine whether the current weight entry is not empty.
  bool get isNotEmpty => this != Weight.empty;

   /// Converts the [Weight] instance to a [WeightEntity].
  WeightEntity toEntity() {
    return WeightEntity(
      id: id,
      weight: weight,
      date: date,
    );
  } 

  /// Creates a [Weight] instance from a [WeightEntity] instance.
  static Weight fromEntity(WeightEntity entity) {
    return Weight(
      id: entity.id,
      weight: entity.weight,
      date: entity.date,
    );
  }

  @override
  List<Object> get props => [id, weight, date];
}