import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/projects_page/projects_repository.dart';

import '../../models/eu_project_model.dart';
import '../../utils/resource.dart';
import 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  final ProjectsRepository _repo;
  late Resource<List<EUProjectModel>> projectsResource;

  ProjectsCubit({
    required ProjectsRepository repo,
  })  : _repo = repo,
        super(ProjectsInitial());

  Future<void> getAllProjects() async {
    emit(ProjectsLoading());
    debugPrint('ProjectLoading State is active');

    projectsResource = await _repo.getAllProjects();
    if (projectsResource.status == Status.SUCCESS) {
      emit(ProjectsSuccess(projectsResource: projectsResource));
      debugPrint('Project Success State is active');
    } else if (projectsResource.status == Status.ERROR) {
      emit(ProjectsError());
      debugPrint('Project Error State is active. Error Message: ${projectsResource.errorMessage}');
    }
  }

  void showProjectsDetail(EUProjectModel project) {
    emit(ProjectsDetail(project: project));
  }
}
