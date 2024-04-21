import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:webspark_test/model/grid_data.dart';

part 'url_checker_state.dart';

class UrlCheckerCubit extends Cubit<UrlCheckerState> {
  UrlCheckerCubit() : super(UrlCheckerState.initial());

  void enterURL(String url) {
    emit(
      UrlCheckerState(
        urlAPI: url,
        errorMessage: '',
        responseStatus: ResponseStatus.initial,
        gridData: [],
      ),
    );
  }

  void saveAndTestURL() async {
    emit(
      UrlCheckerState(
        urlAPI: state.urlAPI,
        errorMessage: '',
        responseStatus: ResponseStatus.loading,
        gridData: [],
      ),
    );
    try {
      final response = await http.get(Uri.parse(state.urlAPI));

      if (response.statusCode == 200) {
        List<GridData> gridData = getGridData(response);
        if (gridData.isNotEmpty) {
          emit(
            UrlCheckerState(
              urlAPI: state.urlAPI,
              errorMessage: '',
              responseStatus: ResponseStatus.success,
              gridData: gridData,
            ),
          );
        } else {
          emit(
            UrlCheckerState(
              urlAPI: state.urlAPI,
              errorMessage: 'URL is not valid or data is empty',
              responseStatus: ResponseStatus.error,
              gridData: [],
            ),
          );
        }
      } else {
        emit(
          UrlCheckerState(
            urlAPI: state.urlAPI,
            errorMessage:
                'URL is unreachable, status code: ${response.statusCode}',
            responseStatus: ResponseStatus.error,
            gridData: [],
          ),
        );
      }
    } catch (e) {
      emit(
        UrlCheckerState(
          urlAPI: state.urlAPI,
          errorMessage: 'Error: Could not reach the URL',
          responseStatus: ResponseStatus.error,
          gridData: [],
        ),
      );
    }
  }

  List<GridData> getGridData(http.Response response) {
    try {
      List<Map<String, dynamic>> dataset =
          List<Map<String, dynamic>>.from(json.decode(response.body)['data']);

      List<GridData> grids =
          dataset.map((data) => GridData.fromJson(data)).toList();

      return grids;
    } catch (e) {
      return [];
    }
  }
}
