// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import 'package:flutter_cloud_firestore_sample_master/workers_list_screen.dart';

import 'firestore_helper.dart';
import 'worker.dart';

class AddEditWorkerScreen extends StatefulWidget {
  final bool isEdit;
  final Worker selectedWorker;

  const AddEditWorkerScreen({
    Key? key,
    required this.isEdit,
    required this.selectedWorker,
  }) : super(key: key);

  @override
  State<AddEditWorkerScreen> createState() => _AddEditWorkerScreenState();
}

class _AddEditWorkerScreenState extends State<AddEditWorkerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Worker Name:", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(controller: nameController),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Worker Salary:", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                        controller: salaryController,
                        keyboardType: TextInputType.number),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Worker Age:", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number),
                  )
                ],
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  var getWorkerName = nameController.text;
                  var getWorkerSalary = salaryController.text;
                  var getWorkerAge = ageController.text;

                  if (getWorkerName.isNotEmpty &&
                      getWorkerSalary.isNotEmpty &&
                      getWorkerAge.isNotEmpty) {
                    if (widget.isEdit) {
                      Worker updateWorker = Worker(
                          workerId: widget.selectedWorker.workerId,
                          workerName: getWorkerName,
                          workerSalary: int.parse(getWorkerSalary),
                          workerAge: int.parse(getWorkerAge));
                      FireStoreHelper.updateWorker(worker: updateWorker);
                    } else {
                      Worker addWorker = Worker(
                          workerName: getWorkerName,
                          workerSalary: int.parse(getWorkerSalary),
                          workerAge: int.parse(getWorkerAge));
                      FireStoreHelper.addWorker(worker: addWorker);
                    }

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WorkersListScreen(),
                        ),
                        (route) => false);
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
