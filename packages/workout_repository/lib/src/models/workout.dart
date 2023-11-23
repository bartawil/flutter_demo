// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class Workout extends Equatable {
	final String id;
	final String email;
	final String firstName;
  final String lastName;
  final String phoneNumber;
  final String age;
  final String height;
  final String weight;
  final double bmi;
  final String gender;
  final DateTime registerDate;
	String? picture;

	Workout({
		required this.id,
		required this.email,
		required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.age,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.gender,
    required this.registerDate,
		this.picture,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = Workout(
		id: '', 
		email: '',
		firstName: '',
    lastName: '', 
    phoneNumber: '',
    age: '',
    height: '',
    weight: '',
    bmi: 0.0,
    gender: '',
    registerDate: DateTime.now(),
		picture: ''
	);

	/// Modify Workout parameters
	Workout copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? age,
    String? height,
    String? weight,
    double? bmi,
    String? gender,
    DateTime? registerDate,
    String? picture,
  }) {
    return Workout(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      gender: gender ?? this.gender,
      registerDate: registerDate ?? this.registerDate,
      picture: picture ?? this.picture,
    );
  }

	/// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Workout.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Workout.empty;

	WorkoutEntity toEntity() {
    return WorkoutEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      age: age,
      height: height,
      weight: weight,
      bmi: bmi,
      gender: gender,
      registerDate: registerDate,
      picture: picture,
    );
  }

	static Workout fromEntity(WorkoutEntity entity) {
    return Workout(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      age: entity.age,
      height: entity.height,
      weight: entity.weight,
      bmi: entity.bmi,
      gender: entity.gender,
      registerDate: entity.registerDate,
      picture: entity.picture,
    );
  }


	@override
	List<Object?> get props => [
    id, email, firstName, lastName, phoneNumber, 
    age, height, weight, bmi, gender, registerDate, picture];
	
}