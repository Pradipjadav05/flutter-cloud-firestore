// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cloud_firestore_sample_master/worker.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
CollectionReference workerCollectionReference =
    firebaseFirestore.collection('workers');

class FireStoreHelper {
  static Stream<QuerySnapshot> getWorkers() {
    return workerCollectionReference.snapshots();
  }

  //Add Workers......
  static Future<void> addWorker({required Worker worker}) async {
    DocumentReference documentReference = workerCollectionReference.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "name": worker.workerName,
      "salary": worker.workerSalary,
      "age": worker.workerAge,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Worker added to the firestore"))
        .catchError((e) => print(e));
  }

  //Update workers...
  static Future<void> updateWorker({required Worker worker}) async {
    DocumentReference documentReference =
        workerCollectionReference.doc(worker.workerId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": worker.workerName,
      "salary": worker.workerSalary,
      "age": worker.workerAge,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("Worker updated in the firestore"))
        .catchError((e) => print(e));
  }

  //Delete worker....

  static Future<void> deleteWorker({required String workerId}) async {
    DocumentReference documentReference =
        workerCollectionReference.doc(workerId);

    await documentReference
        .delete()
        .whenComplete(() => print("Worker deleted from the firestore"))
        .catchError((e) => print(e));
  }
}
