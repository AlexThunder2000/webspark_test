part of 'send_result_cubit.dart';

class SendResultState {
  final String urlAPI;
  final String informMessage;
  final ResponseStatus responseStatus;
  final List<PathResult> resultData;

  const SendResultState({
    required this.urlAPI,
    required this.responseStatus,
    required this.resultData,
    required this.informMessage,
  });

  SendResultState.initial()
      : urlAPI = '',
        responseStatus = ResponseStatus.initial,
        informMessage = '',
        resultData = [];

  bool get isLoading => responseStatus == ResponseStatus.loading;
}
