

import 'homework_model.dart';
import 'my_sessions_model.dart';
import 'resources_model.dart';

class SessionByIdModel {
  SessionsModel? session;
  HomeWorkModel? homework;
  List<ResourcesModel> resources;

  SessionByIdModel(this.session, this.resources, this.homework);
}
