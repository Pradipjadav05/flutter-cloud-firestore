// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore_sample_master/worker.dart';

import 'add_edit_worker_screen.dart';
import 'firestore_helper.dart';

class WorkersListScreen extends StatefulWidget {
  const WorkersListScreen({super.key});

  @override
  State<WorkersListScreen> createState() => _WorkersListScreenState();
}

class _WorkersListScreenState extends State<WorkersListScreen> {
  List<Worker> listWorkers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Cloud Firestore Sample"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEditWorkerScreen(
                            isEdit: false,
                            selectedWorker: Worker(
                                workerName: "", workerSalary: 0, workerAge: 0),
                          )));
            },
          ),
        ],
      ),
      // body: Container(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('workers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error initializing Firebase');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemBuilder: (context, index) {
              var workerdata = snapshot.data!.docs[index].data();
              var docId = snapshot.data!.docs[index].id;
              var getWorker = Worker(
                  workerId: docId,
                  workerName: workerdata['name'],
                  workerSalary: workerdata['salary'],
                  workerAge: workerdata['age']);

              var salary = getWorker.workerSalary;
              var age = getWorker.workerAge;

              listWorkers.add(getWorker);

              return Card(
                elevation: 8,
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(getWorker.workerName,
                            style: const TextStyle(fontSize: 18)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 45),
                          child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AddEditWorkerScreen(
                                              isEdit: true,
                                              selectedWorker: getWorker,
                                            )));
                              }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              FireStoreHelper.deleteWorker(
                                  workerId: getWorker.workerId.toString());
                              setState(() => {
                                    listWorkers.removeWhere((item) =>
                                        item.workerId == getWorker.workerId)
                                  });
                            }),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Salary: $salary | Age: $age",
                              style: const TextStyle(fontSize: 18))),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
