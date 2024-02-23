import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_todo_c10_fri/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollections() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, _) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var tasksCollection = getTasksCollections(); // collection
    var taskDocRef = tasksCollection.doc(); // document
    task.id = taskDocRef.id;

    /// auto id
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTasksCollections().doc(task.id).delete();
  }
}

/// json => format data
/// {}   => json object
/// []   => json Array
