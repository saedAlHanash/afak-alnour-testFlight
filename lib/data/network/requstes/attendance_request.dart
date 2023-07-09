import 'package:json_annotation/json_annotation.dart';
part 'attendance_request.g.dart';

@JsonSerializable()
class AttendanceRequest {
  List<int> students = [];
  String? date =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String? status = 'compelted';

  AttendanceRequest({required this.students, this.date, this.status});

  Map<String, dynamic> toJson() => _$AttendanceRequestToJson(this);
}
