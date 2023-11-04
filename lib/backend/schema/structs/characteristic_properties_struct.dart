// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CharacteristicPropertiesStruct extends FFFirebaseStruct {
  CharacteristicPropertiesStruct({
    bool? broadcast,
    bool? write,
    bool? read,
    bool? writeWithoutResponse,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _broadcast = broadcast,
        _write = write,
        _read = read,
        _writeWithoutResponse = writeWithoutResponse,
        super(firestoreUtilData);

  // "broadcast" field.
  bool? _broadcast;
  bool get broadcast => _broadcast ?? false;
  set broadcast(bool? val) => _broadcast = val;
  bool hasBroadcast() => _broadcast != null;

  // "write" field.
  bool? _write;
  bool get write => _write ?? false;
  set write(bool? val) => _write = val;
  bool hasWrite() => _write != null;

  // "read" field.
  bool? _read;
  bool get read => _read ?? false;
  set read(bool? val) => _read = val;
  bool hasRead() => _read != null;

  // "writeWithoutResponse" field.
  bool? _writeWithoutResponse;
  bool get writeWithoutResponse => _writeWithoutResponse ?? false;
  set writeWithoutResponse(bool? val) => _writeWithoutResponse = val;
  bool hasWriteWithoutResponse() => _writeWithoutResponse != null;

  static CharacteristicPropertiesStruct fromMap(Map<String, dynamic> data) =>
      CharacteristicPropertiesStruct(
        broadcast: data['broadcast'] as bool?,
        write: data['write'] as bool?,
        read: data['read'] as bool?,
        writeWithoutResponse: data['writeWithoutResponse'] as bool?,
      );

  static CharacteristicPropertiesStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? CharacteristicPropertiesStruct.fromMap(data)
          : null;

  Map<String, dynamic> toMap() => {
        'broadcast': _broadcast,
        'write': _write,
        'read': _read,
        'writeWithoutResponse': _writeWithoutResponse,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'broadcast': serializeParam(
          _broadcast,
          ParamType.bool,
        ),
        'write': serializeParam(
          _write,
          ParamType.bool,
        ),
        'read': serializeParam(
          _read,
          ParamType.bool,
        ),
        'writeWithoutResponse': serializeParam(
          _writeWithoutResponse,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CharacteristicPropertiesStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CharacteristicPropertiesStruct(
        broadcast: deserializeParam(
          data['broadcast'],
          ParamType.bool,
          false,
        ),
        write: deserializeParam(
          data['write'],
          ParamType.bool,
          false,
        ),
        read: deserializeParam(
          data['read'],
          ParamType.bool,
          false,
        ),
        writeWithoutResponse: deserializeParam(
          data['writeWithoutResponse'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'CharacteristicPropertiesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CharacteristicPropertiesStruct &&
        broadcast == other.broadcast &&
        write == other.write &&
        read == other.read &&
        writeWithoutResponse == other.writeWithoutResponse;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([broadcast, write, read, writeWithoutResponse]);
}

CharacteristicPropertiesStruct createCharacteristicPropertiesStruct({
  bool? broadcast,
  bool? write,
  bool? read,
  bool? writeWithoutResponse,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CharacteristicPropertiesStruct(
      broadcast: broadcast,
      write: write,
      read: read,
      writeWithoutResponse: writeWithoutResponse,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CharacteristicPropertiesStruct? updateCharacteristicPropertiesStruct(
  CharacteristicPropertiesStruct? characteristicProperties, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    characteristicProperties
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCharacteristicPropertiesStructData(
  Map<String, dynamic> firestoreData,
  CharacteristicPropertiesStruct? characteristicProperties,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (characteristicProperties == null) {
    return;
  }
  if (characteristicProperties.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      characteristicProperties.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final characteristicPropertiesData = getCharacteristicPropertiesFirestoreData(
      characteristicProperties, forFieldValue);
  final nestedData =
      characteristicPropertiesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      characteristicProperties.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCharacteristicPropertiesFirestoreData(
  CharacteristicPropertiesStruct? characteristicProperties, [
  bool forFieldValue = false,
]) {
  if (characteristicProperties == null) {
    return {};
  }
  final firestoreData = mapToFirestore(characteristicProperties.toMap());

  // Add any Firestore field values
  characteristicProperties.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCharacteristicPropertiesListFirestoreData(
  List<CharacteristicPropertiesStruct>? characteristicPropertiess,
) =>
    characteristicPropertiess
        ?.map((e) => getCharacteristicPropertiesFirestoreData(e, true))
        .toList() ??
    [];
