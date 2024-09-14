import 'package:dartz/dartz.dart';
import 'package:ui_core/core/base/base_dio.dart';
import 'package:ui_core/core/base/base_hive.dart';

import '../network/network_info.dart';

class MainRepository {
  final TheHttpExecuter remoteData;
  final HiveStorage localData;
  final NetworkInfo networkInfo;
  Map<String, String> headers = {};
  MainRepository({
    required this.localData,
    required this.networkInfo,
    required this.remoteData,
  }) {
    // _initializeHeaders();
  }

  // Future<void> _initializeHeaders() async {
  //   var token = await localData.getAString(AppApiUrl.TOKEN);
  //   headers = {
  //     'Content-type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $token',
  //   };
  // }
  Future<Either<dynamic, dynamic>> data({
    required Function getData,
    Function(dynamic)? cashData,
    Function? cachedData,
    required bool needCash,
  }) async {
    // this bool is to check if there is connection to the internet
    // if there is no connection it will check if we need to get data from cache
    final bool fromTheApi = await networkInfo.isConnected || cachedData == null;

    if (fromTheApi) {
      // the task that will try to fetch data from the internet
      return Task(() => getData())
          // Automatically catches exceptions
          .attempt()
          // map and return the exception
          // this is an extension from Reso coder
          .mapLeftToFailure()
          // Converts Task back into a Future
          .run()
          // Classic Future continuation
          // the result function will see if we need to cache or
          // just return the value as is
          .then((value) => result(value, cashData, needCash));
    } else {
      // the task that will try to fetch data from the local storage
      // the rest is the same as the function before
      return Task(() => cachedData())
          .attempt()
          .mapLeftToFailure()
          .run()
          .then((value) => value);
    }
  }

  result(
    Either<dynamic, dynamic> value,
    Function(dynamic)? cashData,
    bool needCash,
  ) {
    // it will check if there is a caching function and will use it if needed
    final bool isCashDataNull = cashData != null;

    if (needCash) {
      value.fold((l) => {}, (r) => isCashDataNull ? cashData(r) : {});
    }
    return value;
  }
}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<dynamic, U>> mapLeftToFailure() {
    return map((either) => either.leftMap((obj) {
          return obj;
        }));
  }
}
