import 'package:planner/modules/categories_module/data/category_model.dart';

class User {
  int? id;
  String? firstName;
  String? email;
  List<Category>? categories;
  List<Task>? sharedTasks;
  List<PartnerRequest>? requests;
  List<Partner>? partners;
}

class Partner extends User {
 
}

class PartnerRequest extends RequestModel {}

class AssignTaskRequest extends RequestModel {
  int? taskId;
  String? taskName;
}

class RequestModel {
  int? id;
  int? recieverId;
  bool? isApproved;
  String? requestStatus;
  int? senderId;
  String? sendername;
}
