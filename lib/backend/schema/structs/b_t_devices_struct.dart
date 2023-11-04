// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BTDevicesStruct extends FFFirebaseStruct {
  BTDevicesStruct({
    String? name,
    String? id,
    int? rssi,
    String? type,
    bool? connectable,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _id = id,
        _rssi = rssi,
        _type = type,
        _connectable = connectable,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;
  bool hasId() => _id != null;

  // "rssi" field.
  int? _rssi;
  int get rssi => _rssi ?? 0;
  set rssi(int? val) => _rssi = val;
  void incrementRssi(int amount) => _rssi = rssi + amount;
  bool hasRssi() => _rssi != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;
  bool hasType() => _type != null;

  // "connectable" field.
  bool? _connectable;
  bool get connectable => _connectable ?? false;
  set connectable(bool? val) => _connectable = val;
  bool hasConnectable() => _connectable != null;

  static BTDevicesStruct fromMap(Map<String, dynamic> data) => BTDevicesStruct(
        name: data['name'] as String?,
        id: data['id'] as String?,
        rssi: castToType<int>(data['rssi']),
        type: data['type'] as String?,
        connectable: data['connectable'] as bool?,
      );

  static BTDevicesStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? BTDevicesStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'id': _id,
        'rssi': _rssi,
        'type': _type,
        'connectable': _connectable,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'rssi': serializeParam(
          _rssi,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'connectable': serializeParam(
          _connectable,
          ParamType.bool,
        ),
      }.withoutNulls;

  static BTDevicesStruct fromSerializableMap(Map<String, dynamic> data) =>
      BTDevicesStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        rssi: deserializeParam(
          data['rssi'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        connectable: deserializeParam(
          data['connectable'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'BTDevicesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BTDevicesStruct &&
        name == other.name &&
        id == other.id &&
        rssi == other.rssi &&
        type == other.type &&
        connectable == other.connectable;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, id, rssi, type, connectable]);
}

BTDevicesStruct createBTDevicesStruct({
  String? name,
  String? id,
  int? rssi,
  String? type,
  bool? connectable,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BTDevicesStruct(
      name: name,
      id: id,
      rssi: rssi,
      type: type,
      connectable: connectable,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BTDevicesStruct? updateBTDevicesStruct(
  BTDevicesStruct? bTDevices, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    bTDevices
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBTDevicesStructData(
  Map<String, dynamic> firestoreData,
  BTDevicesStruct? bTDevices,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (bTDevices == null) {
    return;
  }
  if (bTDevices.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && bTDevices.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final bTDevicesData = getBTDevicesFirestoreData(bTDevices, forFieldValue);
  final nestedData = bTDevicesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = bTDevices.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBTDevicesFirestoreData(
  BTDevicesStruct? bTDevices, [
  bool forFieldValue = false,
]) {
  if (bTDevices == null) {
    return {};
  }
  final firestoreData = mapToFirestore(bTDevices.toMap());

  // Add any Firestore field values
  bTDevices.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBTDevicesListFirestoreData(
  List<BTDevicesStruct>? bTDevicess,
) =>
    bTDevicess?.map((e) => getBTDevicesFirestoreData(e, true)).toList() ?? [];
