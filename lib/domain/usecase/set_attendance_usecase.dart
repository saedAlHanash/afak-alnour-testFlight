import '../../data/network/failure.dart';
import '../../data/network/requstes/attendance_request.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class SetAttendanceUseCase
    extends BaseUseCase<SetAttendanceUseCaseInput, void> {
  final Repository _repository;

  SetAttendanceUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(SetAttendanceUseCaseInput input) async {
    return await _repository.setAttendance(
        input.sessionId, input.attendanceRequest);
  }
}

class SetAttendanceUseCaseInput {
  int sessionId;
  AttendanceRequest attendanceRequest;

  SetAttendanceUseCaseInput(this.attendanceRequest, this.sessionId);
}
