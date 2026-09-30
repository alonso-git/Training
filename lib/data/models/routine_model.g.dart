// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRoutineModelCollection on Isar {
  IsarCollection<RoutineModel> get routineModels => this.collection();
}

const RoutineModelSchema = CollectionSchema(
  name: r'RoutineModel',
  id: -1626869750065799181,
  properties: {
    r'dayOfWeek': PropertySchema(
      id: 0,
      name: r'dayOfWeek',
      type: IsarType.longList,
    ),
    r'docId': PropertySchema(
      id: 1,
      name: r'docId',
      type: IsarType.string,
    ),
    r'exerciseIds': PropertySchema(
      id: 2,
      name: r'exerciseIds',
      type: IsarType.stringList,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _routineModelEstimateSize,
  serialize: _routineModelSerialize,
  deserialize: _routineModelDeserialize,
  deserializeProp: _routineModelDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _routineModelGetId,
  getLinks: _routineModelGetLinks,
  attach: _routineModelAttach,
  version: '3.1.0+1',
);

int _routineModelEstimateSize(
  RoutineModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dayOfWeek.length * 8;
  bytesCount += 3 + object.docId.length * 3;
  bytesCount += 3 + object.exerciseIds.length * 3;
  {
    for (var i = 0; i < object.exerciseIds.length; i++) {
      final value = object.exerciseIds[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _routineModelSerialize(
  RoutineModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.dayOfWeek);
  writer.writeString(offsets[1], object.docId);
  writer.writeStringList(offsets[2], object.exerciseIds);
  writer.writeString(offsets[3], object.name);
}

RoutineModel _routineModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoutineModel();
  object.autoId = id;
  object.dayOfWeek = reader.readLongList(offsets[0]) ?? [];
  object.docId = reader.readString(offsets[1]);
  object.exerciseIds = reader.readStringList(offsets[2]) ?? [];
  object.name = reader.readString(offsets[3]);
  return object;
}

P _routineModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _routineModelGetId(RoutineModel object) {
  return object.autoId;
}

List<IsarLinkBase<dynamic>> _routineModelGetLinks(RoutineModel object) {
  return [];
}

void _routineModelAttach(
    IsarCollection<dynamic> col, Id id, RoutineModel object) {
  object.autoId = id;
}

extension RoutineModelByIndex on IsarCollection<RoutineModel> {
  Future<RoutineModel?> getByDocId(String docId) {
    return getByIndex(r'docId', [docId]);
  }

  RoutineModel? getByDocIdSync(String docId) {
    return getByIndexSync(r'docId', [docId]);
  }

  Future<bool> deleteByDocId(String docId) {
    return deleteByIndex(r'docId', [docId]);
  }

  bool deleteByDocIdSync(String docId) {
    return deleteByIndexSync(r'docId', [docId]);
  }

  Future<List<RoutineModel?>> getAllByDocId(List<String> docIdValues) {
    final values = docIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'docId', values);
  }

  List<RoutineModel?> getAllByDocIdSync(List<String> docIdValues) {
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

  Future<Id> putByDocId(RoutineModel object) {
    return putByIndex(r'docId', object);
  }

  Id putByDocIdSync(RoutineModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'docId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDocId(List<RoutineModel> objects) {
    return putAllByIndex(r'docId', objects);
  }

  List<Id> putAllByDocIdSync(List<RoutineModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'docId', objects, saveLinks: saveLinks);
  }
}

extension RoutineModelQueryWhereSort
    on QueryBuilder<RoutineModel, RoutineModel, QWhere> {
  QueryBuilder<RoutineModel, RoutineModel, QAfterWhere> anyAutoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhere> anyDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'docId'),
      );
    });
  }
}

extension RoutineModelQueryWhere
    on QueryBuilder<RoutineModel, RoutineModel, QWhereClause> {
  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> autoIdEqualTo(
      Id autoId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: autoId,
        upper: autoId,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> autoIdNotEqualTo(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> autoIdGreaterThan(
      Id autoId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: autoId, includeLower: include),
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> autoIdLessThan(
      Id autoId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: autoId, includeUpper: include),
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> autoIdBetween(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> docIdEqualTo(
      String docId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'docId',
        value: [docId],
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> docIdNotEqualTo(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> docIdGreaterThan(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> docIdLessThan(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> docIdBetween(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> docIdStartsWith(
      String DocIdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'docId',
        lower: [DocIdPrefix],
        upper: ['$DocIdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause> docIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'docId',
        value: [''],
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterWhereClause>
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
}

extension RoutineModelQueryFilter
    on QueryBuilder<RoutineModel, RoutineModel, QFilterCondition> {
  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> autoIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> autoIdBetween(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayOfWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dayOfWeek',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dayOfWeek',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dayOfWeek',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dayOfWeek',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dayOfWeek',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      dayOfWeekLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dayOfWeek',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> docIdEqualTo(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> docIdLessThan(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> docIdBetween(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> docIdEndsWith(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> docIdContains(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> docIdMatches(
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

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      docIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'docId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      docIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'docId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseIds',
        value: '',
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseIds',
        value: '',
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      exerciseIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exerciseIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension RoutineModelQueryObject
    on QueryBuilder<RoutineModel, RoutineModel, QFilterCondition> {}

extension RoutineModelQueryLinks
    on QueryBuilder<RoutineModel, RoutineModel, QFilterCondition> {}

extension RoutineModelQuerySortBy
    on QueryBuilder<RoutineModel, RoutineModel, QSortBy> {
  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> sortByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> sortByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension RoutineModelQuerySortThenBy
    on QueryBuilder<RoutineModel, RoutineModel, QSortThenBy> {
  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> thenByAutoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoId', Sort.asc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> thenByAutoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoId', Sort.desc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> thenByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> thenByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension RoutineModelQueryWhereDistinct
    on QueryBuilder<RoutineModel, RoutineModel, QDistinct> {
  QueryBuilder<RoutineModel, RoutineModel, QDistinct> distinctByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOfWeek');
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QDistinct> distinctByDocId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'docId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QDistinct> distinctByExerciseIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exerciseIds');
    });
  }

  QueryBuilder<RoutineModel, RoutineModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension RoutineModelQueryProperty
    on QueryBuilder<RoutineModel, RoutineModel, QQueryProperty> {
  QueryBuilder<RoutineModel, int, QQueryOperations> autoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoId');
    });
  }

  QueryBuilder<RoutineModel, List<int>, QQueryOperations> dayOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOfWeek');
    });
  }

  QueryBuilder<RoutineModel, String, QQueryOperations> docIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'docId');
    });
  }

  QueryBuilder<RoutineModel, List<String>, QQueryOperations>
      exerciseIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseIds');
    });
  }

  QueryBuilder<RoutineModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
