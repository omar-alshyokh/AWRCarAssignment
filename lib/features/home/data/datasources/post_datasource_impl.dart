import 'package:car_tracking_app/features/home/data/datasources/post_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/features/home/data/datasources/post_datasource.dart';
import 'package:car_tracking_app/features/home/data/datasources/post_remote_datasource.dart';
import 'package:car_tracking_app/features/home/data/models/post_model.dart';

@LazySingleton(as: PostDatasource)
class PostDatasourceImpl extends PostDatasource {
  final PostLocalDataSource _localDataSource;
  final PostRemoteDataSource _remoteDataSource;

  PostDatasourceImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Result<List<PostModel>>> getPosts({CancelToken? cancelToken}) {
    return _remoteDataSource.getPosts();
  }
}
