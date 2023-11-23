import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
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
	final String? picture;

	const WorkoutEntity({
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

	Map<String, Object?> toDocument() {
    return {
      'id': id,
			'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'age': age, 
      'height': height, 
      'weight': weight, 
      'bmi': bmi,
      'gender': gender,
      'register_date': registerDate,
      'picture': picture,
    };
  }

	static WorkoutEntity fromDocument(Map<String, dynamic> doc) {
    return WorkoutEntity(
      id: doc['id'] as String,
			email: doc['email'] as String,
      firstName: doc['first_name'] as String,
      lastName: doc['last_name'] as String,
      phoneNumber: doc['phone_number'] as String,
      age: doc['age'] as String,
      height: doc['height'] as String,
      weight: doc['weight'] as String,
      bmi: doc['bmi'] as double,
      gender: doc['gender'] as String,
      registerDate: (doc['register_date'] as Timestamp).toDate(),
      picture: doc['picture'] as String?
    );
  }
	
	@override
	List<Object?> get props => [
    id, email, firstName, lastName, phoneNumber, 
    age, height, weight, bmi, gender, registerDate, picture];

	@override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      first_name: $firstName
      last_name: $lastName
      phone_number: $phoneNumber
      age: $age
      height: $height
      weight: $weight
      bmi: $bmi
      gender: $gender
      register_date: $registerDate
      picture: $picture
    }''';
  }
}