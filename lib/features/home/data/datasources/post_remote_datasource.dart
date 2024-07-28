import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/constants/app_endpoints.dart';
import 'package:car_tracking_app/core/managers/network/dio_client.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/features/home/data/models/post_model.dart';

@LazySingleton()
class PostRemoteDataSource {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PostRemoteDataSource(this._dioClient);

  Future<Result<List<PostModel>>> getPosts({CancelToken? cancelToken}) async {
    final res = await _dioClient.getList<PostModel>(
      Endpoints.posts.value,
      cancelToken: cancelToken,
      converter: (json) {
        return PostModel.fromJson(json);
      },
    );
    return res;
  }
}
