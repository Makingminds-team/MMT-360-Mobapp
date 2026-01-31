class ProjectModel {
  int? idProject;
  String? projectName;
  String? shortCode;
  int? type;
  String? content;
  bool? isActive;
  String? projectDate;
  int? projectStatus;
  String? createdOn;
  String? updatedOn;
  int? createdBy;
  int? updatedBy;
  List<Employee>? employee;
  String? typeLabel;
  String? projectStatusLabel;

  ProjectModel(
      {this.idProject,
      this.projectName,
      this.shortCode,
      this.type,
      this.content,
      this.isActive,
      this.projectDate,
      this.projectStatus,
      this.createdOn,
      this.updatedOn,
      this.createdBy,
      this.updatedBy,
      this.employee,
      this.typeLabel,
      this.projectStatusLabel});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    idProject = json['id_project'];
    projectName = json['project_name'];
    shortCode = json['short_code'];
    type = json['type'];
    content = json['content'];
    isActive = json['is_active'];
    projectDate = json['project_date'];
    projectStatus = json['project_status'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
    typeLabel = json['type_label'];
    projectStatusLabel = json['project_status_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_project'] = this.idProject;
    data['project_name'] = this.projectName;
    data['short_code'] = this.shortCode;
    data['type'] = this.type;
    data['content'] = this.content;
    data['is_active'] = this.isActive;
    data['project_date'] = this.projectDate;
    data['project_status'] = this.projectStatus;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    data['type_label'] = this.typeLabel;
    data['project_status_label'] = this.projectStatusLabel;
    return data;
  }
}

class Employee {
  String? firstname;

  Employee({this.firstname});

  Employee.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    return data;
  }
}
