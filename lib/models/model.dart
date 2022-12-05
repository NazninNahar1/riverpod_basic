
import 'dart:convert';

Schertech temperaturesFromJson(String str) => Schertech.fromJson(json.decode(str));

String temperaturesToJson(Schertech data) => json.encode(data.toJson());

class Schertech {
  Schertech({
    required this.total,
    required this.records,
  });

  final int total;
  final List<Record> records;

  factory Schertech.fromJson(Map<String, dynamic> json) => Schertech(
    total: json["total"],
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class Record {
  Record({
    required this.id,
    required this.parentId,
    required this.typeId,
    required this.startDate,
    required this.endDate,
    required this.problem,
    required this.taskType,
    required this.erledigt,
    required this.responsiblePersonNr,
    required this.activeTask,
    required this.responsibleName,
    required this.clientName,
    required this.moduleName,
    required this.isRead,
    required this.estTime,
    required this.sprintName,
    required this.clientId,
    required this.moduleId,
    required this.totalDocs,
    required this.typ,
    required this.allDocs,
  });

  final String id;
  final String parentId;
  final String typeId;
  final DateTime startDate;
  final String endDate;
  final String problem;
  final TaskType? taskType;
  final String erledigt;
  final String responsiblePersonNr;
  final String activeTask;
  final String? responsibleName;
  final String clientName;
  final String moduleName;
  final bool isRead;
  final String estTime;
  final SprintName? sprintName;
  final String clientId;
  final String moduleId;
  final int totalDocs;
  final Typ? typ;
  final List<AllDoc> allDocs;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"]??'',
    parentId: json["parent_id"]??'',
    typeId: json["type_id"]??'',
    startDate: DateTime.parse(json["start_date"]),
    endDate: json["end_date"],
    problem: json["problem"],
    taskType: taskTypeValues.map[json["task_type"]],
    erledigt: json["erledigt"],
    responsiblePersonNr: json["responsible_person_nr"],
    activeTask: json["active_task"]??'',
    responsibleName: json["responsible_name"],
    clientName: json["client_name"] ?? '',
    moduleName: json["module_name"] ?? 'Module',
    isRead: json["is_read"],
    estTime: json["est_time"],
    sprintName: json["sprint_name"] == null ? null : sprintNameValues.map[json["sprint_name"]],
    clientId: json["client_id"] ?? '',
    moduleId: json["module_id"] ?? '',
    totalDocs: json["total_docs"],
    typ: typValues.map[json["typ"]],
    allDocs: List<AllDoc>.from(json["all_docs"].map((x) => AllDoc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "type_id": typeId,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate,
    "problem": problem,
    "task_type": taskTypeValues.reverse![taskType],
    "erledigt": erledigt,
    "responsible_person_nr": responsiblePersonNr,
    "active_task": activeTask,
    "responsible_name": responsibleNameValues.reverse![responsibleName],
    "client_name": clientName,
    "module_name": moduleName,
    "is_read": isRead,
    "est_time": estTime,
    "sprint_name": sprintName == null ? null : sprintNameValues.reverse![sprintName],
    "client_id": clientId,
    "module_id": moduleId,
    "total_docs": totalDocs,
    "typ": typValues.reverse![typ],
    "all_docs": List<dynamic>.from(allDocs.map((x) => x.toJson())),
  };
}

class AllDoc {
  AllDoc({
    required this.docId,
    required this.typ,
    required this.taskId,
    required this.docOriginalName,
    required this.docFileName,
    required this.docSize,
    required this.docPath,
    required this.docExtension,
  });

  final String docId;
  final Typ? typ;
  final String taskId;
  final String docOriginalName;
  final String docFileName;
  final String docSize;
  final String docPath;
  final String docExtension;

  factory AllDoc.fromJson(Map<String, dynamic> json) => AllDoc(
    docId: json["doc_id"],
    typ: typValues.map[json["typ"]],
    taskId: json["task_id"],
    docOriginalName: json["doc_original_name"],
    docFileName: json["doc_file_name"],
    docSize: json["doc_size"],
    docPath: json["doc_path"],
    docExtension: json["doc_extension"],
  );

  Map<String, dynamic> toJson() => {
    "doc_id": docId,
    "typ": typValues.reverse![typ],
    "task_id": taskId,
    "doc_original_name": docOriginalName,
    "doc_file_name": docFileName,
    "doc_size": docSize,
    "doc_path": docPath,
    "doc_extension": docExtension,
  };
}

enum Typ { TEAM, TASK }

final typValues = EnumValues({
  "Task": Typ.TASK,
  "Team": Typ.TEAM
});

enum ProbabilityColor { D9534_F, EC971_F, NULL, THE_449_D44, THE_0069_D9 }

final probabilityColorValues = EnumValues({
  "#d9534f": ProbabilityColor.D9534_F,
  "#ec971f": ProbabilityColor.EC971_F,
  "NULL": ProbabilityColor.NULL,
  "#0069d9": ProbabilityColor.THE_0069_D9,
  "#449d44": ProbabilityColor.THE_449_D44
});

enum ResponsibleName { MR_OMER_ARAFAT, SORONIKA_SARKER_PINKEY, FAISAL_AHMED, JEWEL_ASHRAFUL_ALAM, BIPROJIT_ROY }

final responsibleNameValues = EnumValues({
  "Biprojit, Roy": ResponsibleName.BIPROJIT_ROY,
  "Faisal Ahmed": ResponsibleName.FAISAL_AHMED,
  "Jewel Ashraful, Alam": ResponsibleName.JEWEL_ASHRAFUL_ALAM,
  "Mr. Omer Arafat": ResponsibleName.MR_OMER_ARAFAT,
  "Soronika Sarker Pinkey ": ResponsibleName.SORONIKA_SARKER_PINKEY
});

enum SprintName { SPRINT_95, SPRINT_96, SPRINT_97, SPRINT_98 }

final sprintNameValues = EnumValues({
  "Sprint 95": SprintName.SPRINT_95,
  "Sprint 96": SprintName.SPRINT_96,
  "Sprint 97": SprintName.SPRINT_97,
  "Sprint 98": SprintName.SPRINT_98
});

enum TaskType { TEAM, MY_TASK }

final taskTypeValues = EnumValues({
  "my_task": TaskType.MY_TASK,
  "team": TaskType.TEAM
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
