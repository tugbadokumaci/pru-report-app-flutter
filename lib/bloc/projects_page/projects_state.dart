import '../../models/eu_project_model.dart';
import '../../utils/resource.dart';

abstract class ProjectsState {}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsSuccess extends ProjectsState {
  final Resource<List<EUProjectModel>> projectsResource;

  ProjectsSuccess({required this.projectsResource});
}

class ProjectsDetail extends ProjectsState {
  final EUProjectModel project;

  ProjectsDetail({required this.project});
}

class ProjectsError extends ProjectsState {}
