
import 'package:dio/dio.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/features/home/data/models/post_model.dart';

abstract class PostDatasource {
  Future<Result<List<PostModel>>> getPosts(
      {CancelToken? cancelToken});
}