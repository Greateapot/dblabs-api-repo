library api_repository.io;

import 'package:dblabs_api/dblabs_api.dart';
import 'package:grpc/grpc.dart';

import 'src/dblabs_api_repo_base.dart';

export 'package:dblabs_api/dblabs_api.dart';
export 'src/api_exception.dart';
export 'src/table.dart';
export 'src/dblabs_api_repo_base.dart';

final class ApiRepositoryImpl extends ApiRepository {
  ApiRepositoryImpl.fromChannel(final ClientChannel channel)
      : _channel = channel,
        _client = ApiClient(channel);

  factory ApiRepositoryImpl(
    String host, {
    int port = 5555,
    bool isSecure = false,
  }) {
    final instance = ApiRepositoryImpl.fromChannel(
        ClientChannel(
          host,
          port: port,
          options: ChannelOptions(
            credentials: isSecure
                ? ChannelCredentials.secure()
                : ChannelCredentials.insecure(),
          ),
        ),
      );
    ApiRepository.instance = instance;
    return instance;
  }

  final ClientChannel _channel;
  final ApiClient _client;

  @override
  ApiClient get client => _client;

  @override
  void dispose() async => await _channel.shutdown();
}
