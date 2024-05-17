abstract class ScanState {}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanSuccess extends ScanState {}

class ScanPasswordChange extends ScanState {}

class ScanError extends ScanState {}
