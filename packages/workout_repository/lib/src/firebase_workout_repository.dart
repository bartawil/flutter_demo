import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_repository/workout_repository.dart';

/// A repository for accessing and managing workouts using Firebase services.
class FirebaseWorkoutRepository implements WorkoutRepository {
  final workoutsCollection = FirebaseFirestore.instance.collection('workouts');

  /// Retrieves a workout by its category and ID.
  ///
  /// [category] specifies the category of the workout.
  /// [workoutId] is the unique identifier of the workout.
  ///
  /// Returns the retrieved [Workout] object.
  @override
  Future<Workout> getWorkoutById(String category, String workoutId) async {
    try {
      DocumentSnapshot snapshot = await workoutsCollection
          .doc(category)
          .collection(category)
          .doc(workoutId)
          .get();

      Workout workout = Workout.fromEntity(
          WorkoutEntity.fromDocument(snapshot.data() as Map<String, dynamic>));

      return workout;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Retrieves a list of workouts by their type.
  ///
  /// [type] specifies the type of workouts to retrieve.
  ///
  /// Returns a list of [Workout] objects.
  @override
  Future<List<Workout>> getWorkoutsList(String type) async {
    try {
      QuerySnapshot snapshot = await workoutsCollection.doc(type).collection(type).get();
      List<Workout> list = snapshot.docs
        .map((doc) {
          try {
            return Workout.fromEntity(WorkoutEntity.fromDocument(
                doc.data() as Map<String, dynamic>));
          } catch (e) {
            return null;
          }
        })
        .where((item) => item != null)
        .cast<Workout>()
        .toList();

      return list;
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves a URL for a GIF.
  ///
  /// Returns a [String] URL of a GIF.
  @override
  Future<String> getGif() async {
    try {
      // uploadAllGifs();
      Reference firebaseStoreRef = FirebaseStorage.instance
          .ref()
          .child('workout/Legs/barbell-rack-pull.gif');
      String url = await firebaseStoreRef.getDownloadURL();
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Helper function to upload all GIFs to Firestore collection.
  Future<void> uploadAllGifs() async {
    try {
      Reference firebaseStoreRef1 =
          FirebaseStorage.instance.ref().child('workout');
      ListResult result1 = await firebaseStoreRef1.listAll();

      List<String> subfolderNames = [];

      for (Reference ref in result1.prefixes) {
        String subfolderName = ref.name;
        subfolderNames.add(subfolderName);
      }

      for (String folder in subfolderNames) {
        Reference firebaseStoreRef =
            FirebaseStorage.instance.ref().child('workout/$folder');
        ListResult result = await firebaseStoreRef.listAll();

        for (Reference ref in result.items) {
          String url = await ref.getDownloadURL();
          String name = ref.name
              .toLowerCase()
              .replaceAll('-', ' ')
              .replaceAll('_', ' ')
              .replaceAll('.gif', '');
          String category = folder;

          Workout newWorkout = Workout(
            id: const Uuid().v4(),
            name: name,
            category: category,
            gifUrl: url,
          );

          await workoutsCollection
            .doc(folder)
            .collection(folder)
            .doc(newWorkout.id)
            .set({
              'id': newWorkout.id,
              'name': newWorkout.name,
              'category': newWorkout.category,
              'gifUrl': newWorkout.gifUrl,
            });

          // await workoutsCollection.doc(newWorkout.name).set({
          //   'name': newWorkout.name,
          //   'category': newWorkout.category,
          //   'gifUrl': newWorkout.gifUrl,
          // });
        }
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
