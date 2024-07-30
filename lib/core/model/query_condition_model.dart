enum QueryConditionOperatorType {
  isGreaterThan,
  isEqualTo,
  isLessThan,
}

class QueryConditionModel {
  final String field;
  final dynamic value;
  final QueryConditionOperatorType operator;

  QueryConditionModel(
      {required this.field,
      this.value,
      this.operator = QueryConditionOperatorType.isEqualTo});
}
