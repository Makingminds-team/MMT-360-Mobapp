class DashboardEmployeeSummaryModel {
  int? employeeCount;
  int? clientCount;
  int? projectsCount;
  int? ongoingProjects;
  int? onholdProjects;
  int? ontestingProjects;
  int? completedProjects;

  DashboardEmployeeSummaryModel(
      {this.employeeCount,
      this.clientCount,
      this.projectsCount,
      this.ongoingProjects,
      this.onholdProjects,
      this.ontestingProjects,
      this.completedProjects});

  DashboardEmployeeSummaryModel.fromJson(Map<String, dynamic> json) {
    employeeCount = json['employee_count'];
    clientCount = json['client_count'];
    projectsCount = json['projects_count'];
    ongoingProjects = json['ongoing_projects'];
    onholdProjects = json['onhold_projects'];
    ontestingProjects = json['ontesting_projects'];
    completedProjects = json['completed_projects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_count'] = this.employeeCount;
    data['client_count'] = this.clientCount;
    data['projects_count'] = this.projectsCount;
    data['ongoing_projects'] = this.ongoingProjects;
    data['onhold_projects'] = this.onholdProjects;
    data['ontesting_projects'] = this.ontestingProjects;
    data['completed_projects'] = this.completedProjects;
    return data;
  }
}
