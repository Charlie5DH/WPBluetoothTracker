// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BluetoothDescriptorStruct extends FFFirebaseStruct {
  BluetoothDescriptorStruct({
    String? uuid,
    String? deviceId,
    String? serviceUuid,
    String? characteristicUuid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _uuid = uuid,
        _deviceId = deviceId,
        _serviceUuid = serviceUuid,
        _characteristicUuid = characteristicUuid,
        super(firestoreUtilData);

  // "uuid" field.
  String? _uuid;
  String get uuid => _uuid ?? '';
  set uuid(String? val) => _uuid = val;
  bool hasUuid() => _uuid != null;

  // "deviceId" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  set deviceId(String? val) => _deviceId = val;
  bool hasDeviceId() => _deviceId != null;

  // "serviceUuid" field.
  String? _serviceUuid;
  String get serviceUuid => _serviceUuid ?? '';
  set serviceUuid(String? val) => _serviceUuid = val;
  bool hasServiceUuid() => _serviceUuid != null;

  // "characteristicUuid" field.
  String? _characteristicUuid;
  String get characteristicUuid => _characteristicUuid ?? '';
  set characteristicUuid(String? val) => _characteristicUuid = val;
  bool hasCharacteristicUuid() => _characteristicUuid != null;

  static BluetoothDescriptorStruct fromMap(Map<String, dynamic> data) =>
      BluetoothDescriptorStruct(
        uuid: data['uuid'] as String?,
        deviceId: data['deviceId'] as String?,
        serviceUuid: data['serviceUuid'] as String?,
        characteristicUuid: data['characteristicUuid'] as String?,
      );

  static BluetoothDescriptorStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? BluetoothDescriptorStruct.fromMap(data)
          : null;

  Map<String, dynamic> toMap() => {
        'uuid': _uuid,
        'deviceId': _deviceId,
        'serviceUuid': _serviceUuid,
        'characteristicUuid': _characteristicUuid,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'uuid': serializeParam(
          _uuid,
          ParamType.String,
        ),
        'deviceId': serializeParam(
          _deviceId,
          ParamType.String,
        ),
        'serviceUuid': serializeParam(
          _serviceUuid,
          ParamType.String,
        ),
        'characteristicUuid': serializeParam(
          _characteristicUuid,
          ParamType.String,
        ),
      }.withoutNulls;

  static BluetoothDescriptorStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BluetoothDescriptorStruct(
        uuid: deserializeParam(
          data['uuid'],
          ParamType.String,
          false,
        ),
        deviceId: deserializeParam(
          data['deviceId'],
          ParamType.String,
          false,
        ),
        serviceUuid: deserializeParam(
          data['serviceUuid'],
          ParamType.String,
          false,
        ),
        characteristicUuid: deserializeParam(
          data['characteristicUuid'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BluetoothDescriptorStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BluetoothDescriptorStruct &&
        uuid == other.uuid &&
        deviceId == other.deviceId &&
        serviceUuid == other.serviceUuid &&
        characteristicUuid == other.characteristicUuid;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([uuid, deviceId, serviceUuid, characteristicUuid]);
}

BluetoothDescriptorStruct createBluetoothDescriptorStruct({
  String? uuid,
  String? deviceId,
  String? serviceUuid,
  String? characteristicUuid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BluetoothDescriptorStruct(
      uuid: uuid,
      deviceId: deviceId,
      serviceUuid: serviceUuid,
      characteristicUuid: characteristicUuid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BluetoothDescriptorStruct? updateBluetoothDescriptorStruct(
  BluetoothDescriptorStruct? bluetoothDescriptor, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    bluetoothDescriptor
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBluetoothDescriptorStructData(
  Map<String, dynamic> firestoreData,
  BluetoothDescriptorStruct? bluetoothDescriptor,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (bluetoothDescriptor == null) {
    return;
  }
  if (bluetoothDescriptor.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && bluetoothDescriptor.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final bluetoothDescriptorData =
      getBluetoothDescriptorFirestoreData(bluetoothDescriptor, forFieldValue);
  final nestedData =
      bluetoothDescriptorData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      bluetoothDescriptor.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBluetoothDescriptorFirestoreData(
  BluetoothDescriptorStruct? bluetoothDescriptor, [
  bool forFieldValue = false,
]) {
  if (bluetoothDescriptor == null) {
    return {};
  }
  final firestoreData = mapToFirestore(bluetoothDescriptor.toMap());

  // Add any Firestore field values
  bluetoothDescriptor.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBluetoothDescriptorListFirestoreData(
  List<BluetoothDescriptorStruct>? bluetoothDescriptors,
) =>
    bluetoothDescriptors
        ?.map((e) => getBluetoothDescriptorFirestoreData(e, true))
        .toList() ??
    [];
