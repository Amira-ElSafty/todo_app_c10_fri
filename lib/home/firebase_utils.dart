import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_todo_c10_fri/model/my_user.dart';
import 'package:flutter_app_todo_c10_fri/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollections(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, _) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task, String uId) {
    var tasksCollection = getTasksCollections(uId); // collection
    var taskDocRef = tasksCollection.doc(); // document
    task.id = taskDocRef.id;

    /// auto id
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId) {
    return getTasksCollections(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, options) =>
                MyUser.fromFireStore(snapshot.data())),
            toFirestore: (user, _) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }
}

