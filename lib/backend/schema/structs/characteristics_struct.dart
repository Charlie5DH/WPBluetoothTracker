// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CharacteristicsStruct extends FFFirebaseStruct {
  CharacteristicsStruct({
    String? characteristicUuid,
    String? descriptorUuid,
    String? serviceUuid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _characteristicUuid = characteristicUuid,
        _descriptorUuid = descriptorUuid,
        _serviceUuid = serviceUuid,
        super(firestoreUtilData);

  // "characteristic_uuid" field.
  String? _characteristicUuid;
  String get characteristicUuid => _characteristicUuid ?? '';
  set characteristicUuid(String? val) => _characteristicUuid = val;
  bool hasCharacteristicUuid() => _characteristicUuid != null;

  // "descriptor_uuid" field.
  String? _descriptorUuid;
  String get descriptorUuid => _descriptorUuid ?? '';
  set descriptorUuid(String? val) => _descriptorUuid = val;
  bool hasDescriptorUuid() => _descriptorUuid != null;

  // "service_uuid" field.
  String? _serviceUuid;
  String get serviceUuid => _serviceUuid ?? '';
  set serviceUuid(String? val) => _serviceUuid = val;
  bool hasServiceUuid() => _serviceUuid != null;

  static CharacteristicsStruct fromMap(Map<String, dynamic> data) =>
      CharacteristicsStruct(
        characteristicUuid: data['characteristic_uuid'] as String?,
        descriptorUuid: data['descriptor_uuid'] as String?,
        serviceUuid: data['service_uuid'] as String?,
      );

  static CharacteristicsStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? CharacteristicsStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'characteristic_uuid': _characteristicUuid,
        'descriptor_uuid': _descriptorUuid,
        'service_uuid': _serviceUuid,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'characteristic_uuid': serializeParam(
          _characteristicUuid,
          ParamType.String,
        ),
        'descriptor_uuid': serializeParam(
          _descriptorUuid,
          ParamType.String,
        ),
        'service_uuid': serializeParam(
          _serviceUuid,
          ParamType.String,
        ),
      }.withoutNulls;

  static CharacteristicsStruct fromSerializableMap(Map<String, dynamic> data) =>
      CharacteristicsStruct(
        characteristicUuid: deserializeParam(
          data['characteristic_uuid'],
          ParamType.String,
          false,
        ),
        descriptorUuid: deserializeParam(
          data['descriptor_uuid'],
          ParamType.String,
          false,
        ),
        serviceUuid: deserializeParam(
          data['service_uuid'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CharacteristicsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CharacteristicsStruct &&
        characteristicUuid == other.characteristicUuid &&
        descriptorUuid == other.descriptorUuid &&
        serviceUuid == other.serviceUuid;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([characteristicUuid, descriptorUuid, serviceUuid]);
}

CharacteristicsStruct createCharacteristicsStruct({
  String? characteristicUuid,
  String? descriptorUuid,
  String? serviceUuid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CharacteristicsStruct(
      characteristicUuid: characteristicUuid,
      descriptorUuid: descriptorUuid,
      serviceUuid: serviceUuid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CharacteristicsStruct? updateCharacteristicsStruct(
  CharacteristicsStruct? characteristics, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    characteristics
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCharacteristicsStructData(
  Map<String, dynamic> firestoreData,
  CharacteristicsStruct? characteristics,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (characteristics == null) {
    return;
  }
  if (characteristics.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && characteristics.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final characteristicsData =
      getCharacteristicsFirestoreData(characteristics, forFieldValue);
  final nestedData =
      characteristicsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = characteristics.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCharacteristicsFirestoreData(
  CharacteristicsStruct? characteristics, [
  bool forFieldValue = false,
]) {
  if (characteristics == null) {
    return {};
  }
  final firestoreData = mapToFirestore(characteristics.toMap());

  // Add any Firestore field values
  characteristics.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCharacteristicsListFirestoreData(
  List<CharacteristicsStruct>? characteristicss,
) =>
    characteristicss
        ?.map((e) => getCharacteristicsFirestoreData(e, true))
        .toList() ??
    [];
