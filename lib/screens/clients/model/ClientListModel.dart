class ClientListModel {
  List<Columns>? columns;
  Actions? actions;
  int? pageCount;
  int? totalPages;
  int? currentPage;
  List<Rows>? rows;
  int? noOfRecords;

  ClientListModel(
      {this.columns,
      this.actions,
      this.pageCount,
      this.totalPages,
      this.currentPage,
      this.rows,
      this.noOfRecords});

  ClientListModel.fromJson(Map<String, dynamic> json) {
    if (json['columns'] != null) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(new Columns.fromJson(v));
      });
    }
    actions =
        json['actions'] != null ? new Actions.fromJson(json['actions']) : null;
    pageCount = json['page_count'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
    noOfRecords = json['no_of_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.columns != null) {
      data['columns'] = this.columns!.map((v) => v.toJson()).toList();
    }
    if (this.actions != null) {
      data['actions'] = this.actions!.toJson();
    }
    data['page_count'] = this.pageCount;
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    data['no_of_records'] = this.noOfRecords;
    return data;
  }
}

class Columns {
  String? accessorKey;
  String? header;
  String? textAlign;
  String? columnType;
  String? id;

  Columns(
      {this.accessorKey,
      this.header,
      this.textAlign,
      this.columnType,
      this.id});

  Columns.fromJson(Map<String, dynamic> json) {
    accessorKey = json['accessorKey'];
    header = json['header'];
    textAlign = json['text_align'];
    columnType = json['column_type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessorKey'] = this.accessorKey;
    data['header'] = this.header;
    data['text_align'] = this.textAlign;
    data['column_type'] = this.columnType;
    data['id'] = this.id;
    return data;
  }
}

class Actions {
  bool? isAddReq;
  bool? isEditReq;
  bool? isDeleteReq;
  bool? isPrintReq;
  bool? isCancelReq;
  bool? isRevertReq;

  Actions(
      {this.isAddReq,
      this.isEditReq,
      this.isDeleteReq,
      this.isPrintReq,
      this.isCancelReq,
      this.isRevertReq});

  Actions.fromJson(Map<String, dynamic> json) {
    isAddReq = json['is_add_req'];
    isEditReq = json['is_edit_req'];
    isDeleteReq = json['is_delete_req'];
    isPrintReq = json['is_print_req'];
    isCancelReq = json['is_cancel_req'];
    isRevertReq = json['is_revert_req'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_add_req'] = this.isAddReq;
    data['is_edit_req'] = this.isEditReq;
    data['is_delete_req'] = this.isDeleteReq;
    data['is_print_req'] = this.isPrintReq;
    data['is_cancel_req'] = this.isCancelReq;
    data['is_revert_req'] = this.isRevertReq;
    return data;
  }
}

class Rows {
  int? idClient;
  String? name;
  String? mobileNo;
  String? mobCode;
  String? address1;
  String? address2;
  String? pincode;
  String? gstNumber;
  String? companyName;
  String? companyAddress;
  String? projectEstimation;
  String? projectDescription;
  String? initialAmount;
  String? totalAmount;
  String? startDate;
  String? endDate;
  String? duration;
  String? nda;
  bool? isActive;
  String? createdOn;
  String? updatedOn;
  int? project;
  int? createdBy;
  int? updatedBy;
  int? pkId;
  int? sno;

  Rows(
      {this.idClient,
      this.name,
      this.mobileNo,
      this.mobCode,
      this.address1,
      this.address2,
      this.pincode,
      this.gstNumber,
      this.companyName,
      this.companyAddress,
      this.projectEstimation,
      this.projectDescription,
      this.initialAmount,
      this.totalAmount,
      this.startDate,
      this.endDate,
      this.duration,
      this.nda,
      this.isActive,
      this.createdOn,
      this.updatedOn,
      this.project,
      this.createdBy,
      this.updatedBy,
      this.pkId,
      this.sno});

  Rows.fromJson(Map<String, dynamic> json) {
    idClient = json['id_client'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    mobCode = json['mob_code'];
    address1 = json['address1'];
    address2 = json['address2'];
    pincode = json['pincode'];
    gstNumber = json['gst_number'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    projectEstimation = json['project_estimation'];
    projectDescription = json['project_description'];
    initialAmount = json['initial_amount'];
    totalAmount = json['total_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    duration = json['duration'];
    nda = json['nda'];
    isActive = json['is_active'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    project = json['project'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    pkId = json['pk_id'];
    sno = json['sno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_client'] = this.idClient;
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['mob_code'] = this.mobCode;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['pincode'] = this.pincode;
    data['gst_number'] = this.gstNumber;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['project_estimation'] = this.projectEstimation;
    data['project_description'] = this.projectDescription;
    data['initial_amount'] = this.initialAmount;
    data['total_amount'] = this.totalAmount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['duration'] = this.duration;
    data['nda'] = this.nda;
    data['is_active'] = this.isActive;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['project'] = this.project;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['pk_id'] = this.pkId;
    data['sno'] = this.sno;
    return data;
  }
}
