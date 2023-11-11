import 'package:dblabs_api/dblabs_api.dart';
import 'api_exception.dart';
import 'table.dart';

abstract base class ApiRepository {
  ApiClient get client;

  void dispose();

  Future<void> createTrigger({
    required String triggerName,
    required TriggerTimeType triggerTime,
    required TriggerEventType triggerEvent,
    required String tableName,
    required String triggerBody,
    TriggerOrder? triggerOrder,
  }) async {
    OkResponse response = await client.createTrigger(CreateTriggerRequest(
      triggerName: triggerName,
      triggerTime: triggerTime,
      triggerEvent: triggerEvent,
      tableName: tableName,
      triggerBody: triggerBody,
      triggerOrder: triggerOrder,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> dropTrigger({
    required String triggerName,
  }) async {
    OkResponse response = await client.dropTrigger(DropTriggerRequest(
      triggerName: triggerName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> alterDatabase({
    required String databaseName,
    ReadOnly? readOnly,
  }) async {
    OkResponse response = await client.alterDatabase(AlterDatabaseRequest(
      databaseName: databaseName,
      readOnly: readOnly,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> createDatabase({
    required String databaseName,
  }) async {
    OkResponse response = await client.createDatabase(CreateDatabaseRequest(
      databaseName: databaseName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> dropDatabase({
    required String databaseName,
  }) async {
    OkResponse response = await client.dropDatabase(DropDatabaseRequest(
      databaseName: databaseName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> alterTable({
    required String tableName,
    required Iterable<AlterTableOption> options,
  }) async {
    OkResponse response = await client.alterTable(AlterTableRequest(
      tableName: tableName,
      options: options,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> createTable({
    required String tableName,
    required Iterable<CreateTableOption> options,
  }) async {
    OkResponse response = await client.createTable(CreateTableRequest(
      tableName: tableName,
      options: options,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> dropTable({
    required String tableName,
  }) async {
    OkResponse response = await client.dropTable(DropTableRequest(
      tableName: tableName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> renameTable({
    required String oldTableName,
    required String newTableName,
  }) async {
    OkResponse response = await client.renameTable(RenameTableRequest(
      oldTableName: oldTableName,
      newTableName: newTableName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> truncateTable({
    required String tableName,
  }) async {
    OkResponse response = await client.truncateTable(TruncateTableRequest(
      tableName: tableName,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> delete({
    required String tableName,
    String? tableAlias,
    String? whereCondition,
    OrderBy? orderBy,
    int? limit,
  }) async {
    OkResponse response = await client.delete(DeleteRequest(
      tableName: tableName,
      tableAlias: tableAlias,
      whereCondition: whereCondition,
      orderBy: orderBy,
      limit: limit,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> update({
    required String tableName,
    required AssignmentList assignmentList,
    String? whereCondition,
    OrderBy? orderBy,
    int? limit,
  }) async {
    OkResponse response = await client.update(UpdateRequest(
      tableName: tableName,
      assignmentList: assignmentList,
      whereCondition: whereCondition,
      orderBy: orderBy,
      limit: limit,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<void> insert({
    required String tableName,
    required InsertType insertType,
    Iterable<String>? columnNames,
    SelectData? selectData,
    String? otherTableName,
    RowConstructorList? rowConstructorList,
    AssignmentList? onDuplicateKeyUpdate,
  }) async {
    OkResponse response = await client.insert(InsertRequest(
      tableName: tableName,
      columnNames: columnNames,
      insertType: insertType,
      selectData: selectData,
      otherTableName: otherTableName,
      rowConstructorList: rowConstructorList,
      onDuplicateKeyUpdate: onDuplicateKeyUpdate,
    ));
    if (!response.ok) throw ApiException.fromResponseError(response.error);
  }

  Future<Table> select({
    required SelectData selectData,
  }) async {
    TableResponse response = await client.select(SelectRequest(
      selectData: selectData,
    ));
    return response.ok
        ? Table.fromJson(selectData.columnNames, response.data)
        : throw ApiException.fromResponseError(response.error);
  }

  Future<Table> join({
    required Iterable<String> columnNames,
    required String firstTableName,
    required String secondTableName,
    required Join join,
    String? firstTableAlias,
    String? secondTableAlias,
    String? whereCondition,
    OrderBy? orderBy,
  }) async {
    TableResponse response = await client.join(JoinRequest(
      columnNames: columnNames,
      join: join,
      firstTableName: firstTableName,
      secondTableName: secondTableName,
      firstTableAlias: firstTableAlias,
      secondTableAlias: secondTableAlias,
      whereCondition: whereCondition,
      orderBy: orderBy,
    ));
    return response.ok
        ? Table.fromJson(columnNames.toList(), response.data)
        : throw ApiException.fromResponseError(response.error);
  }

  Future<Table> showDatabases({
    bool? showSys,
  }) async {
    TableResponse response = await client.showDatabases(ShowDatabasesRequest(
      showSys: showSys,
    ));
    return response.ok
        ? Table.fromJson(["SCHEMA_NAME"], response.data)
        : throw ApiException.fromResponseError(response.error);
  }

  Future<Table> showTables({
    required String databaseName,
  }) async {
    TableResponse response = await client.showTables(ShowTablesRequest(
      databaseName: databaseName,
    ));
    return response.ok
        ? Table.fromJson(["TABLE_NAME"], response.data)
        : throw ApiException.fromResponseError(response.error);
  }

  Future<Table> showTableStruct({
    required String databaseName,
    required String tableName,
  }) async {
    TableResponse response = await client.showTableStruct(
      ShowTableStructRequest(
        databaseName: databaseName,
        tableName: tableName,
      ),
    );
    return response.ok
        ? Table.fromJson(
            [
              "COLUMN_NAME",
              "COLUMN_TYPE",
              "IS_NULLABLE",
              "COLUMN_KEY",
              "COLUMN_DEFAULT",
              "EXTRA",
            ],
            response.data,
          )
        : throw ApiException.fromResponseError(response.error);
  }
}
