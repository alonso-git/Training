// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExerciseModelCollection on Isar {
  IsarCollection<ExerciseModel> get exerciseModels => this.collection();
}

const ExerciseModelSchema = CollectionSchema(
  name: r'ExerciseModel',
  id: -3488639855911673103,
  properties: {
    r'docId': PropertySchema(
      id: 0,
      name: r'docId',
      type: IsarType.string,
    ),
    r'isCustom': PropertySchema(
      id: 1,
      name: r'isCustom',
      type: IsarType.bool,
    ),
    r'maxReps': PropertySchema(
      id: 2,
      name: r'maxReps',
      type: IsarType.long,
    ),
    r'minReps': PropertySchema(
      id: 3,
      name: r'minReps',
      type: IsarType.long,
    ),
    r'muscleGroup': PropertySchema(
      id: 4,
      name: r'muscleGroup',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'sets': PropertySchema(
      id: 6,
      name: r'sets',
      type: IsarType.long,
    ),
    r'weightIncrement': PropertySchema(
      id: 7,
      name: r'weightIncrement',
      type: IsarType.double,
    )
  },
  estimateSize: _exerciseModelEstimateSize,
  serialize: _exerciseModelSerialize,
  deserialize: _exerciseModelDeserialize,
  deserializeProp: _exerciseModelDeserializeProp,
  idName: r'autoId',
  indexes: {
    r'docId': IndexSchema(
      id: -9164048795576814174,
      name: r'docId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'docId',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'muscleGroup': IndexSchema(
      id: 9219781228009971960,
      name: r'muscleGroup',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'muscleGroup',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _exerciseModelGetId,
  getLinks: _exerciseModelGetLinks,
  attach: _exerciseModelAttach,
  version: '3.1.0+1',
);

int _exerciseModelEstimateSize(
  ExerciseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.docId.length * 3;
  bytesCount += 3 + object.muscleGroup.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _exerciseModelSerialize(
  ExerciseModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.docId);
  writer.writeBool(offsets[1], object.isCustom);
  writer.writeLong(offsets[2], object.maxReps);
  writer.writeLong(offsets[3], object.minReps);
  writer.writeString(offsets[4], object.muscleGroup);
  writer.writeString(offsets[5], object.name);
  writer.writeLong(offsets[6], object.sets);
  writer.writeDouble(offsets[7], object.weightIncrement);
}

ExerciseModel _exerciseModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseModel();
  object.autoId = id;
  object.docId = reader.readString(offsets[0]);
  object.isCustom = reader.readBool(offsets[1]);
  object.maxReps = reader.readLong(offsets[2]);
  object.minReps = reader.readLong(offsets[3]);
  object.muscleGroup = reader.readString(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.sets = reader.readLong(offsets[6]);
  object.weightIncrement = reader.readDouble(offsets[7]);
  return object;
}

P _exerciseModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _exerciseModelGetId(ExerciseModel object) {
  return object.autoId;
}

List<IsarLinkBase<dynamic>> _exerciseModelGetLinks(ExerciseModel object) {
  return [];
}

void _exerciseModelAttach(
    IsarCollection<dynamic> col, Id id, ExerciseModel object) {
  object.autoId = id;
}

extension ExerciseModelQueryWhereSort
    on QueryBuilder<ExerciseModel, ExerciseModel, QWhere> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhere> anyAutoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhere> anyDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'docId'),
      );
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhere> anyMuscleGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'muscleGroup'),
      );
    });
  }
}

extension ExerciseModelQueryWhere
    on QueryBuilder<ExerciseModel, ExerciseModel, QWhereClause> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> autoIdEqualTo(
      Id autoId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: autoId,
        upper: autoId,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      autoIdNotEqualTo(Id autoId) {
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      autoIdGreaterThan(Id autoId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: autoId, includeLower: include),
      );
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> autoIdLessThan(
      Id autoId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: autoId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> autoIdBetween(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> docIdEqualTo(
      String docId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'docId',
        value: [docId],
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> docIdNotEqualTo(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      docIdGreaterThan(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> docIdLessThan(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> docIdBetween(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> docIdStartsWith(
      String DocIdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'docId',
        lower: [DocIdPrefix],
        upper: ['$DocIdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> docIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'docId',
        value: [''],
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupEqualTo(String muscleGroup) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'muscleGroup',
        value: [muscleGroup],
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupNotEqualTo(String muscleGroup) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'muscleGroup',
              lower: [],
              upper: [muscleGroup],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'muscleGroup',
              lower: [muscleGroup],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'muscleGroup',
              lower: [muscleGroup],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'muscleGroup',
              lower: [],
              upper: [muscleGroup],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupGreaterThan(
    String muscleGroup, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'muscleGroup',
        lower: [muscleGroup],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupLessThan(
    String muscleGroup, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'muscleGroup',
        lower: [],
        upper: [muscleGroup],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupBetween(
    String lowerMuscleGroup,
    String upperMuscleGroup, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'muscleGroup',
        lower: [lowerMuscleGroup],
        includeLower: includeLower,
        upper: [upperMuscleGroup],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupStartsWith(String MuscleGroupPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'muscleGroup',
        lower: [MuscleGroupPrefix],
        upper: ['$MuscleGroupPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'muscleGroup',
        value: [''],
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause>
      muscleGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'muscleGroup',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'muscleGroup',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'muscleGroup',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'muscleGroup',
              upper: [''],
            ));
      }
    });
  }
}

extension ExerciseModelQueryFilter
    on QueryBuilder<ExerciseModel, ExerciseModel, QFilterCondition> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      autoIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      autoIdBetween(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdEqualTo(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdLessThan(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdBetween(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdEndsWith(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'docId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'docId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'docId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      docIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'docId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      isCustomEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCustom',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      maxRepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      maxRepsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      maxRepsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      maxRepsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxReps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      minRepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      minRepsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      minRepsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minReps',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      minRepsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minReps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'muscleGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'muscleGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'muscleGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'muscleGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'muscleGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'muscleGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'muscleGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'muscleGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'muscleGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      muscleGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'muscleGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> setsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      setsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      setsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> setsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      weightIncrementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightIncrement',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      weightIncrementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightIncrement',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      weightIncrementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightIncrement',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
      weightIncrementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightIncrement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ExerciseModelQueryObject
    on QueryBuilder<ExerciseModel, ExerciseModel, QFilterCondition> {}

extension ExerciseModelQueryLinks
    on QueryBuilder<ExerciseModel, ExerciseModel, QFilterCondition> {}

extension ExerciseModelQuerySortBy
    on QueryBuilder<ExerciseModel, ExerciseModel, QSortBy> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      sortByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByMaxReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReps', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByMaxRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReps', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByMinReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minReps', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByMinRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minReps', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByMuscleGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      sortByMuscleGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortBySets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> sortBySetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      sortByWeightIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      sortByWeightIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.desc);
    });
  }
}

extension ExerciseModelQuerySortThenBy
    on QueryBuilder<ExerciseModel, ExerciseModel, QSortThenBy> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByAutoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByAutoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      thenByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByMaxReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReps', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByMaxRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxReps', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByMinReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minReps', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByMinRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minReps', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByMuscleGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      thenByMuscleGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleGroup', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenBySets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenBySetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.desc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      thenByWeightIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy>
      thenByWeightIncrementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightIncrement', Sort.desc);
    });
  }
}

extension ExerciseModelQueryWhereDistinct
    on QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> {
  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> distinctByDocId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'docId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> distinctByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustom');
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> distinctByMaxReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxReps');
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> distinctByMinReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minReps');
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> distinctByMuscleGroup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'muscleGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> distinctBySets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sets');
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QDistinct>
      distinctByWeightIncrement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightIncrement');
    });
  }
}

extension ExerciseModelQueryProperty
    on QueryBuilder<ExerciseModel, ExerciseModel, QQueryProperty> {
  QueryBuilder<ExerciseModel, int, QQueryOperations> autoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoId');
    });
  }

  QueryBuilder<ExerciseModel, String, QQueryOperations> docIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'docId');
    });
  }

  QueryBuilder<ExerciseModel, bool, QQueryOperations> isCustomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustom');
    });
  }

  QueryBuilder<ExerciseModel, int, QQueryOperations> maxRepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxReps');
    });
  }

  QueryBuilder<ExerciseModel, int, QQueryOperations> minRepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minReps');
    });
  }

  QueryBuilder<ExerciseModel, String, QQueryOperations> muscleGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'muscleGroup');
    });
  }

  QueryBuilder<ExerciseModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ExerciseModel, int, QQueryOperations> setsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sets');
    });
  }

  QueryBuilder<ExerciseModel, double, QQueryOperations>
      weightIncrementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightIncrement');
    });
  }
}
