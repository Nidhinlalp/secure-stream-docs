// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHighlightModelCollection on Isar {
  IsarCollection<HighlightModel> get highlightModels => this.collection();
}

const HighlightModelSchema = CollectionSchema(
  name: r'HighlightModel',
  id: 8278649049609836408,
  properties: {
    r'bottom': PropertySchema(id: 0, name: r'bottom', type: IsarType.double),
    r'colorValue': PropertySchema(
      id: 1,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'docId': PropertySchema(id: 3, name: r'docId', type: IsarType.string),
    r'highlightId': PropertySchema(
      id: 4,
      name: r'highlightId',
      type: IsarType.string,
    ),
    r'left': PropertySchema(id: 5, name: r'left', type: IsarType.double),
    r'page': PropertySchema(id: 6, name: r'page', type: IsarType.long),
    r'right': PropertySchema(id: 7, name: r'right', type: IsarType.double),
    r'text': PropertySchema(id: 8, name: r'text', type: IsarType.string),
    r'top': PropertySchema(id: 9, name: r'top', type: IsarType.double),
  },

  estimateSize: _highlightModelEstimateSize,
  serialize: _highlightModelSerialize,
  deserialize: _highlightModelDeserialize,
  deserializeProp: _highlightModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _highlightModelGetId,
  getLinks: _highlightModelGetLinks,
  attach: _highlightModelAttach,
  version: '3.3.2',
);

int _highlightModelEstimateSize(
  HighlightModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.docId.length * 3;
  bytesCount += 3 + object.highlightId.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _highlightModelSerialize(
  HighlightModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bottom);
  writer.writeLong(offsets[1], object.colorValue);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.docId);
  writer.writeString(offsets[4], object.highlightId);
  writer.writeDouble(offsets[5], object.left);
  writer.writeLong(offsets[6], object.page);
  writer.writeDouble(offsets[7], object.right);
  writer.writeString(offsets[8], object.text);
  writer.writeDouble(offsets[9], object.top);
}

HighlightModel _highlightModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HighlightModel();
  object.bottom = reader.readDouble(offsets[0]);
  object.colorValue = reader.readLongOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.docId = reader.readString(offsets[3]);
  object.highlightId = reader.readString(offsets[4]);
  object.id = id;
  object.left = reader.readDouble(offsets[5]);
  object.page = reader.readLong(offsets[6]);
  object.right = reader.readDouble(offsets[7]);
  object.text = reader.readString(offsets[8]);
  object.top = reader.readDouble(offsets[9]);
  return object;
}

P _highlightModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _highlightModelGetId(HighlightModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _highlightModelGetLinks(HighlightModel object) {
  return [];
}

void _highlightModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  HighlightModel object,
) {
  object.id = id;
}

extension HighlightModelQueryWhereSort
    on QueryBuilder<HighlightModel, HighlightModel, QWhere> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HighlightModelQueryWhere
    on QueryBuilder<HighlightModel, HighlightModel, QWhereClause> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension HighlightModelQueryFilter
    on QueryBuilder<HighlightModel, HighlightModel, QFilterCondition> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  bottomEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bottom',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  bottomGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bottom',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  bottomLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bottom',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  bottomBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bottom',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  colorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'colorValue'),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  colorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'colorValue'),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  colorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'colorValue', value: value),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  colorValueGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'colorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  colorValueLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'colorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  colorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'colorValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'docId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'docId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'docId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'docId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'docId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'docId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'docId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'docId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'docId', value: ''),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  docIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'docId', value: ''),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'highlightId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'highlightId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'highlightId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'highlightId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'highlightId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'highlightId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'highlightId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'highlightId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'highlightId', value: ''),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  highlightIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'highlightId', value: ''),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  leftEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'left',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  leftGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'left',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  leftLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'left',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  leftBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'left',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  pageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'page', value: value),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  pageGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'page',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  pageLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'page',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  pageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'page',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  rightEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'right',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  rightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'right',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  rightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'right',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  rightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'right',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'text',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'text',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'text', value: ''),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'text', value: ''),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  topEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'top',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  topGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'top',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  topLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'top',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterFilterCondition>
  topBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'top',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension HighlightModelQueryObject
    on QueryBuilder<HighlightModel, HighlightModel, QFilterCondition> {}

extension HighlightModelQueryLinks
    on QueryBuilder<HighlightModel, HighlightModel, QFilterCondition> {}

extension HighlightModelQuerySortBy
    on QueryBuilder<HighlightModel, HighlightModel, QSortBy> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByBottom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottom', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  sortByBottomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottom', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  sortByHighlightId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highlightId', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  sortByHighlightIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highlightId', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'left', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'left', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'right', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'right', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByTop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'top', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> sortByTopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'top', Sort.desc);
    });
  }
}

extension HighlightModelQuerySortThenBy
    on QueryBuilder<HighlightModel, HighlightModel, QSortThenBy> {
  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByBottom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottom', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  thenByBottomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottom', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByDocId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByDocIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'docId', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  thenByHighlightId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highlightId', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy>
  thenByHighlightIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highlightId', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'left', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'left', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'right', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'right', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByTop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'top', Sort.asc);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QAfterSortBy> thenByTopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'top', Sort.desc);
    });
  }
}

extension HighlightModelQueryWhereDistinct
    on QueryBuilder<HighlightModel, HighlightModel, QDistinct> {
  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByBottom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bottom');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct>
  distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByDocId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'docId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct>
  distinctByHighlightId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'highlightId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'left');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'page');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'right');
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HighlightModel, HighlightModel, QDistinct> distinctByTop() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'top');
    });
  }
}

extension HighlightModelQueryProperty
    on QueryBuilder<HighlightModel, HighlightModel, QQueryProperty> {
  QueryBuilder<HighlightModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HighlightModel, double, QQueryOperations> bottomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bottom');
    });
  }

  QueryBuilder<HighlightModel, int?, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<HighlightModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<HighlightModel, String, QQueryOperations> docIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'docId');
    });
  }

  QueryBuilder<HighlightModel, String, QQueryOperations> highlightIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'highlightId');
    });
  }

  QueryBuilder<HighlightModel, double, QQueryOperations> leftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'left');
    });
  }

  QueryBuilder<HighlightModel, int, QQueryOperations> pageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'page');
    });
  }

  QueryBuilder<HighlightModel, double, QQueryOperations> rightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'right');
    });
  }

  QueryBuilder<HighlightModel, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<HighlightModel, double, QQueryOperations> topProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'top');
    });
  }
}
