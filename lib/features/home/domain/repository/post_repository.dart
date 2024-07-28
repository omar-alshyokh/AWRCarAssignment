import 'package:dio/dio.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/features/home/domain/entity/post_entity.dart';

abstract class PostRepository {
  Future<Result<List<PostEntity>>> getPosts({CancelToken? cancelToken});
}