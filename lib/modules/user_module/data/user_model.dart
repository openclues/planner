import 'dart:convert';

import 'package:planner/modules/categories_module/data/category_model.dart';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? picImage;
  String? email;
  List<Category>? categories = [];
  List<Task>? sharedTasks;
  // List<Event>? events;
  List<PartnerRequest>? requests;
  List<Partner>? partners = [];
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.picImage,
    this.email,
    this.categories,
    this.sharedTasks,
    this.requests,
    this.partners,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'picImage': picImage,
      'email': email,
      'categories': categories?.map((x) => x.toMap()).toList(),
      'sharedTasks': sharedTasks?.map((x) => x.toMap()).toList(),
      'requests': requests?.map((x) => x.toMap()).toList(),
      'partners': partners?.map((x) => x.toMap()).toList(),
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    if (map["my_categories"] != null) {
      for (var cat in map["my_categories"]) {
        categories!.add(Category.fromMap(cat));
      }
    }
    id = map['id']?.toInt();
    firstName = map['first_name'];
    lastName = map['last_name'];
    picImage = map['pic_image'];
    email = map['email'];
    // sharedTasks =  map['sharedTasks'] != null
    //     ? List<Task>.from(map['sharedTasks']?.map((x) => Task.fromMap(x)))
    //     : null,
    // requests: map['requests'] != null
    //     ? List<PartnerRequest>.from(
    //         map['requests']?.map((x) => PartnerRequest.fromMap(x)))
    //     : null,
    // partners: map['partners'] != null
    //     ? List<Partner>.from(map['partners']?.map((x) => Partner.fromMap(x)))
    //     : null,
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

class Partner {
  String? name;
  Partner({
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Partner.fromMap(Map<String, dynamic> map) {
    return Partner(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Partner.fromJson(String source) =>
      Partner.fromMap(json.decode(source));
}

class PartnerRequest extends RequestModel {
  toMap() {}

  static fromMap(x) {}
}

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
