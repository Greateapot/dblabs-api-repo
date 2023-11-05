library api_repository.web;

import 'package:dblabs_api/dblabs_api.dart';
import 'package:grpc/grpc_web.dart';

import 'src/dblabs_api_repo_base.dart';

export 'package:dblabs_api/dblabs_api.dart';
export 'src/api_exception.dart';
export 'src/table.dart';
export 'src/dblabs_api_repo_base.dart';

final class ApiRepositoryImpl extends ApiRepository {
  ApiRepositoryImpl.fromChannel(final GrpcWebClientChannel channel)
      : _channel = channel,
        _client = ApiClient(channel);

  factory ApiRepositoryImpl(
    String host, {
    int port = 80,
    bool isSecure = false,
  }) =>
      ApiRepositoryImpl.fromChannel(
        GrpcWebClientChannel.xhr(
          Uri.parse('http${isSecure ? 's' : ''}://$host:$port/'),
        ),
      );

  final GrpcWebClientChannel _channel;
  final ApiClient _client;

  @override
  ApiClient get client => _client;

  @override
  void dispose() async => await _channel.shutdown();
}
