part of 'url_checker_cubit.dart';

enum ResponseStatus {
  initial,
  loading,
  success,
  error,
}

class UrlCheckerState {
  final String urlAPI;
  final String errorMessage;
  final ResponseStatus responseStatus;
  final List<GridData> gridData;

  UrlCheckerState({
    required this.urlAPI,
    required this.errorMessage,
    required this.responseStatus,
    required this.gridData,
  });

  UrlCheckerState.initial()
      : urlAPI = '',
        responseStatus = ResponseStatus.initial,
        gridData = [],
        errorMessage = '';

  bool get isNextStepAvailable => responseStatus == ResponseStatus.success;
  bool get isButtonAvailable => !isLoading && !isError;

  bool get isLoading => responseStatus == ResponseStatus.loading;
  bool get isError => responseStatus == ResponseStatus.error;
  bool get isSuccess => responseStatus == ResponseStatus.success;
}
