import 'package:dblabs_api/dblabs_api.dart';
import 'api_exception.dart';

abstract base class ApiRepository {
  ApiClient get client;

  void dispose();

  Future<void> alterDatabase(
    String databaseName,
    ReadOnly readOnly,
  ) async {
    OkResponse response = await client.alterDatabase(AlterDatabaseRequest(
      databaseName: databaseName,
      readOnly: readOnly,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> createDatabase(
    String databaseName,
  ) async {
    OkResponse response = await client.createDatabase(CreateDatabaseRequest(
      databaseName: databaseName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> dropDatabase(
    String databaseName,
  ) async {
    OkResponse response = await client.dropDatabase(DropDatabaseRequest(
      databaseName: databaseName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> alterTable(
    String tableName,
    Iterable<AlterTableOption> options,
  ) async {
    OkResponse response = await client.alterTable(AlterTableRequest(
      tableName: tableName,
      options: options,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> createTable(
    String tableName,
    Iterable<CreateTableOption> options,
  ) async {
    OkResponse response = await client.createTable(CreateTableRequest(
      tableName: tableName,
      options: options,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> dropTable(
    String tableName,
  ) async {
    OkResponse response = await client.dropTable(DropTableRequest(
      tableName: tableName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> renameTable(
    String oldTableName,
    String newTableName,
  ) async {
    OkResponse response = await client.renameTable(RenameTableRequest(
      oldTableName: oldTableName,
      newTableName: newTableName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> truncateTable(
    String tableName,
  ) async {
    OkResponse response = await client.truncateTable(TruncateTableRequest(
      tableName: tableName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }
}
