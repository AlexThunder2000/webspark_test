import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:webspark_test/cubit/url_checker/url_checker_cubit.dart';
import 'package:webspark_test/model/path_result.dart';

part 'send_result_state.dart';

class SendResultCubit extends Cubit<SendResultState> {
  SendResultCubit() : super(SendResultState.initial());

  Future<void> sendResults(List<PathResult> resultData, String urlAPI) async {
    emit(
      SendResultState(
        urlAPI: urlAPI,
        responseStatus: ResponseStatus.loading,
        resultData: resultData,
        informMessage: '',
      ),
    );

    try {
      final response = await http.post(
        Uri.parse(state.urlAPI),
        body: jsonEncode(resultData),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        emit(
          SendResultState(
            urlAPI: urlAPI,
            responseStatus: ResponseStatus.success,
            resultData: resultData,
            informMessage: '',
          ),
        );
      } else {
        emit(
          SendResultState(
            urlAPI: urlAPI,
            responseStatus: ResponseStatus.error,
            resultData: resultData,
            informMessage:
                'Failed to send data. Status Code: ${response.statusCode}.',
          ),
        );
      }
    } catch (e) {
      emit(
        SendResultState(
          urlAPI: urlAPI,
          responseStatus: ResponseStatus.error,
          resultData: resultData,
          informMessage: 'Error occurred: $e',
        ),
      );
    }
  }
}
