// ignore_for_file: public_member_api_docs, sort_constructors_first
class Worker {
  String? workerId = "";
  String workerName = "";
  int workerSalary = 0;
  int workerAge = 0;

  Worker({
    this.workerId,
    required this.workerName,
    required this.workerSalary,
    required this.workerAge,
  });
}
