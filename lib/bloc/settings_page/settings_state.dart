abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
//   final Resource<List<UserModel>> fetchResource;

//   SettingsSuccess({required this.fetchResource});
}

class SettingsPasswordChange extends SettingsState {}

class SettingsError extends SettingsState {}
