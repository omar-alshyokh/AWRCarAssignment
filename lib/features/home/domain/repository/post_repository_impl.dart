import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/core/repository/base_repository.dart';
import 'package:car_tracking_app/features/home/data/datasources/post_datasource.dart';
import 'package:car_tracking_app/features/home/data/models/post_model.dart';
import 'package:car_tracking_app/features/home/domain/entity/post_entity.dart';
import 'package:car_tracking_app/features/home/domain/repository/post_repository.dart';

@LazySingleton()
class PostRepositoryImpl extends BaseRepository implements PostRepository {
  PostDatasource _datasource;

  PostRepositoryImpl(this._datasource);

  @override
  Future<Result<List<PostEntity>>> getPosts({
    CancelToken? cancelToken,
  }) async {
    final result = await _datasource.getPosts();
    return executeForList<PostModel, PostEntity>(remoteResult: result);
  }
}
