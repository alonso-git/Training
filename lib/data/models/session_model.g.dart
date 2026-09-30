// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSessionModelCollection on Isar {
  IsarCollection<SessionModel> get sessionModels => this.collection();
}

const SessionModelSchema = CollectionSchema(
  name: r'SessionModel',
  id: 3961338372060081682,
  properties: {
    r'dateUtcMs': PropertySchema(
      id: 0,
      name: r'dateUtcMs',
      type: IsarType.long,
    ),
    r'docId': PropertySchema(
      id: 1,
      name: r'docId',
      type: IsarType.string,
    ),
    r'durationSeconds': PropertySchema(
      id: 2,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'exerciseLogs': PropertySchema(
      id: 3,
      name: r'exerciseLogs',
      type: IsarType.objectList,
      target: r'ExerciseLogModel',
    ),
    r'routineId': PropertySchema(
      id: 4,
      name: r'routineId',
      type: IsarType.string,
    ),
    r'routineName': PropertySchema(
      id: 5,
      name: r'routineName',
      type: IsarType.string,
    )
  },
  estimateSize: _sessionModelEstimateSize,
  serialize: _sessionModelSerialize,
  deserialize: _sessionModelDeserialize,
  deserializeProp: _sessionModelDeserializeProp,
  idName: r'autoId',
  indexes: {
    r'docId': IndexSchema(
      id: -9164048795576814174,
      name: r'docId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'docId',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'routineId': IndexSchema(
      id: -7971259615846791236,
      name: r'routineId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'routineId',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'dateUtcMs': IndexSchema(
      id: 8712481519191520168,
      name: r'dateUtcMs',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateUtcMs',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'ExerciseLogModel': ExerciseLogModelSchema},
  getId: _sessionModelGetId,
  getLinks: _sessionModelGetLinks,
  attach: _sessionModelAttach,
  version: '3.1.0+1',
);

int _sessionModelEstimateSize(
  SessionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.docId.length * 3;
  bytesCount += 3 + object.exerciseLogs.length * 3;
  {
    final offsets = allOffsets[ExerciseLogModel]!;
    for (var i = 0; i < object.exerciseLogs.length; i++) {
      final value = object.exerciseLogs[i];
      bytesCount +=
          ExerciseLogModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.routineId.length * 3;
  bytesCount += 3 + object.routineName.length * 3;
  return bytesCount;
}

void _sessionModelSerialize(
  SessionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.dateUtcMs);
  writer.writeString(offsets[1], object.docId);
  writer.writeLong(offsets[2], object.durationSeconds);
  writer.writeObjectList<ExerciseLogModel>(
    offsets[3],
    allOffsets,
    ExerciseLogModelSchema.serialize,
    object.exerciseLogs,
  );
  writer.writeString(offsets[4], object.routineId);
  writer.writeString(offsets[5], object.routineName);
}

SessionModel _sessionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SessionModel();
  object.autoId = id;
  object.dateUtcMs = reader.readLong(offsets[0]);
  object.docId = reader.readString(offsets[1]);
  object.durationSeconds = reader.readLong(offsets[2]);
  object.exerciseLogs = reader.readObjectList<ExerciseLogModel>(
        offsets[3],
        ExerciseLogModelSchema.deserialize,
        allOffsets,
        ExerciseLogModel(),
      ) ??
      [];
  object.routineId = reader.readString(offsets[4]);
  object.routineName = reader.readString(offsets[5]);
  return object;
}

P _sessionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readObjectList<ExerciseLogModel>(
            offset,
            ExerciseLogModelSchema.deserialize,
            allOffsets,
            ExerciseLogModel(),
          ) ??
          []) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sessionModelGetId(SessionModel object) {
  return object.autoId;
}

List<IsarLinkBase<dynamic>> _sessionModelGetLinks(SessionModel object) {
  return [];
}

void _sessionModelAttach(
    IsarCollection<dynamic> col, Id id, SessionModel object) {
  object.autoId = id;
}

extension SessionModelByIndex on IsarCollection<SessionModel> {
  Future<SessionModel?> getByDocId(String docId) {
    return getByIndex(r'docId', [docId]);
  }

  SessionModel? getByDocIdSync(String docId) {
    return getByIndexSync(r'docId', [docId]);
  }

  Future<bool> deleteByDocId(String docId) {
    return deleteByIndex(r'docId', [docId]);
  }

  bool deleteByDocIdSync(String docId) {
    return deleteByIndexSync(r'docId', [docId]);
  }

  Future<List<SessionModel?>> getAllByDocId(List<String> docIdValues) {
    final values = docIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'docId', values);
  }

  List<SessionModel?> getAllByDocIdSync(List<String> docIdValues) {
    final values = docIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'docId', values);
  }

  Future<int> deleteAllByDocId(List<String> docIdValues) {
    final values = docIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'docId', values);
  }

  int deleteAllByDocIdSync(List<String> docIdValues) {
    final values = docIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'docId', values);
  }

  Future<Id> putByDocId(SessionModel object) {
    return putByIndex(r'docId', object);
  }

  Id putByDocIdSync(SessionModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'docId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDocId(List<SessionModel> objects) {
    return putAllByIndex(r'docId', objects);
  }

  List<Id> putAllByDocIdSync(List<SessionModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'docId', objects, saveLinks: saveLinks);
  }
}

extension SessionModelQueryWhereSort
    on QueryBuilder<SessionModel, SessionModel, QWhere> {
  QueryBuilder<SessionModel, SessionModel, QAfterWhere> anyAutoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhere> anyDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'docId'),
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhere> anyRoutineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'routineId'),
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhere> anyDateUtcMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateUtcMs'),
      );
    });
  }
}

extension SessionModelQueryWhere
    on QueryBuilder<SessionModel, SessionModel, QWhereClause> {
  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> autoIdEqualTo(
      Id autoId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: autoId,
        upper: autoId,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> autoIdNotEqualTo(
      Id autoId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: autoId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: autoId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: autoId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: autoId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> autoIdGreaterThan(
      Id autoId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: autoId, includeLower: include),
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> autoIdLessThan(
      Id autoId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: autoId, includeUpper: include),
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> autoIdBetween(
    Id lowerAutoId,
    Id upperAutoId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerAutoId,
        includeLower: includeLower,
        upper: upperAutoId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> docIdEqualTo(
      String docId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'docId',
        value: [docId],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> docIdNotEqualTo(
      String docId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'docId',
              lower: [],
              upper: [docId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'docId',
              lower: [docId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'docId',
              lower: [docId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'docId',
              lower: [],
              upper: [docId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> docIdGreaterThan(
    String docId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'docId',
        lower: [docId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> docIdLessThan(
    String docId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'docId',
        lower: [],
        upper: [docId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> docIdBetween(
    String lowerDocId,
    String upperDocId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'docId',
        lower: [lowerDocId],
        includeLower: includeLower,
        upper: [upperDocId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> docIdStartsWith(
      String DocIdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'docId',
        lower: [DocIdPrefix],
        upper: ['$DocIdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> docIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'docId',
        value: [''],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      docIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'docId',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'docId',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'docId',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'docId',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> routineIdEqualTo(
      String routineId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'routineId',
        value: [routineId],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      routineIdNotEqualTo(String routineId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineId',
              lower: [],
              upper: [routineId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineId',
              lower: [routineId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineId',
              lower: [routineId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineId',
              lower: [],
              upper: [routineId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      routineIdGreaterThan(
    String routineId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'routineId',
        lower: [routineId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> routineIdLessThan(
    String routineId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'routineId',
        lower: [],
        upper: [routineId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> routineIdBetween(
    String lowerRoutineId,
    String upperRoutineId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'routineId',
        lower: [lowerRoutineId],
        includeLower: includeLower,
        upper: [upperRoutineId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      routineIdStartsWith(String RoutineIdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'routineId',
        lower: [RoutineIdPrefix],
        upper: ['$RoutineIdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      routineIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'routineId',
        value: [''],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      routineIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'routineId',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'routineId',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'routineId',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'routineId',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> dateUtcMsEqualTo(
      int dateUtcMs) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateUtcMs',
        value: [dateUtcMs],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      dateUtcMsNotEqualTo(int dateUtcMs) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtcMs',
              lower: [],
              upper: [dateUtcMs],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtcMs',
              lower: [dateUtcMs],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtcMs',
              lower: [dateUtcMs],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtcMs',
              lower: [],
              upper: [dateUtcMs],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause>
      dateUtcMsGreaterThan(
    int dateUtcMs, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateUtcMs',
        lower: [dateUtcMs],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> dateUtcMsLessThan(
    int dateUtcMs, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateUtcMs',
        lower: [],
        upper: [dateUtcMs],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterWhereClause> dateUtcMsBetween(
    int lowerDateUtcMs,
    int upperDateUtcMs, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateUtcMs',
        lower: [lowerDateUtcMs],
        includeLower: includeLower,
        upper: [upperDateUtcMs],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SessionModelQueryFilter
    on QueryBuilder<SessionModel, SessionModel, QFilterCondition> {
  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> autoIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoId',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      autoIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'autoId',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      autoIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'autoId',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> autoIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'autoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      dateUtcMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateUtcMs',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      dateUtcMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateUtcMs',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      dateUtcMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateUtcMs',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      dateUtcMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateUtcMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> docIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'docId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      docIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'docId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> docIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'docId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> docIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'docId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      docIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'docId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> docIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'docId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> docIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'docId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition> docIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'docId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      docIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'docId',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      docIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'docId',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      durationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      durationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      exerciseLogsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseLogs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      exerciseLogsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseLogs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      exerciseLogsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseLogs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      exerciseLogsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseLogs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      exerciseLogsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseLogs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      exerciseLogsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseLogs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routineId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routineId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineId',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routineId',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routineName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routineName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineName',
        value: '',
      ));
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      routineNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routineName',
        value: '',
      ));
    });
  }
}

extension SessionModelQueryObject
    on QueryBuilder<SessionModel, SessionModel, QFilterCondition> {
  QueryBuilder<SessionModel, SessionModel, QAfterFilterCondition>
      exerciseLogsElement(FilterQuery<ExerciseLogModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'exerciseLogs');
    });
  }
}

extension SessionModelQueryLinks
    on QueryBuilder<SessionModel, SessionModel, QFilterCondition> {}

extension SessionModelQuerySortBy
    on QueryBuilder<SessionModel, SessionModel, QSortBy> {
  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> sortByDateUtcMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtcMs', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> sortByDateUtcMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtcMs', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> sortByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> sortByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy>
      sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy>
      sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> sortByRoutineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> sortByRoutineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> sortByRoutineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy>
      sortByRoutineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.desc);
    });
  }
}

extension SessionModelQuerySortThenBy
    on QueryBuilder<SessionModel, SessionModel, QSortThenBy> {
  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByAutoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoId', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByAutoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoId', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByDateUtcMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtcMs', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByDateUtcMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtcMs', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy>
      thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy>
      thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByRoutineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByRoutineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.desc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy> thenByRoutineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.asc);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QAfterSortBy>
      thenByRoutineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.desc);
    });
  }
}

extension SessionModelQueryWhereDistinct
    on QueryBuilder<SessionModel, SessionModel, QDistinct> {
  QueryBuilder<SessionModel, SessionModel, QDistinct> distinctByDateUtcMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateUtcMs');
    });
  }

  QueryBuilder<SessionModel, SessionModel, QDistinct> distinctByDocId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'docId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QDistinct>
      distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<SessionModel, SessionModel, QDistinct> distinctByRoutineId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SessionModel, SessionModel, QDistinct> distinctByRoutineName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineName', caseSensitive: caseSensitive);
    });
  }
}

extension SessionModelQueryProperty
    on QueryBuilder<SessionModel, SessionModel, QQueryProperty> {
  QueryBuilder<SessionModel, int, QQueryOperations> autoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoId');
    });
  }

  QueryBuilder<SessionModel, int, QQueryOperations> dateUtcMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateUtcMs');
    });
  }

  QueryBuilder<SessionModel, String, QQueryOperations> docIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'docId');
    });
  }

  QueryBuilder<SessionModel, int, QQueryOperations> durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<SessionModel, List<ExerciseLogModel>, QQueryOperations>
      exerciseLogsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseLogs');
    });
  }

  QueryBuilder<SessionModel, String, QQueryOperations> routineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineId');
    });
  }

  QueryBuilder<SessionModel, String, QQueryOperations> routineNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineName');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ExerciseLogModelSchema = Schema(
  name: r'ExerciseLogModel',
  id: 7670247789362624056,
  properties: {
    r'exerciseId': PropertySchema(
      id: 0,
      name: r'exerciseId',
      type: IsarType.string,
    ),
    r'setReps': PropertySchema(
      id: 1,
      name: r'setReps',
      type: IsarType.longList,
    ),
    r'weight': PropertySchema(
      id: 2,
      name: r'weight',
      type: IsarType.double,
    )
  },
  estimateSize: _exerciseLogModelEstimateSize,
  serialize: _exerciseLogModelSerialize,
  deserialize: _exerciseLogModelDeserialize,
  deserializeProp: _exerciseLogModelDeserializeProp,
);

int _exerciseLogModelEstimateSize(
  ExerciseLogModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.exerciseId.length * 3;
  bytesCount += 3 + object.setReps.length * 8;
  return bytesCount;
}

void _exerciseLogModelSerialize(
  ExerciseLogModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.exerciseId);
  writer.writeLongList(offsets[1], object.setReps);
  writer.writeDouble(offsets[2], object.weight);
}

ExerciseLogModel _exerciseLogModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseLogModel();
  object.exerciseId = reader.readString(offsets[0]);
  object.setReps = reader.readLongList(offsets[1]) ?? [];
  object.weight = reader.readDouble(offsets[2]);
  return object;
}

P _exerciseLogModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ExerciseLogModelQueryFilter
    on QueryBuilder<ExerciseLogModel, ExerciseLogModel, QFilterCondition> {
  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      exerciseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'setReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'setReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'setReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'setReps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'setReps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'setReps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'setReps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'setReps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'setReps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      setRepsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'setReps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      weightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      weightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      weightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExerciseLogModel, ExerciseLogModel, QAfterFilterCondition>
      weightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ExerciseLogModelQueryObject
    on QueryBuilder<ExerciseLogModel, ExerciseLogModel, QFilterCondition> {}
