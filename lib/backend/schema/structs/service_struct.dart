// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServiceStruct extends FFFirebaseStruct {
  ServiceStruct({
    String? uuid,
    bool? primary,
    String? name,
    List<ServiceCharacteristicStruct>? bluetoothCharacteristic,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _uuid = uuid,
        _primary = primary,
        _name = name,
        _bluetoothCharacteristic = bluetoothCharacteristic,
        super(firestoreUtilData);

  // "uuid" field.
  String? _uuid;
  String get uuid => _uuid ?? '';
  set uuid(String? val) => _uuid = val;
  bool hasUuid() => _uuid != null;

  // "primary" field.
  bool? _primary;
  bool get primary => _primary ?? false;
  set primary(bool? val) => _primary = val;
  bool hasPrimary() => _primary != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "bluetoothCharacteristic" field.
  List<ServiceCharacteristicStruct>? _bluetoothCharacteristic;
  List<ServiceCharacteristicStruct> get bluetoothCharacteristic =>
      _bluetoothCharacteristic ?? const [];
  set bluetoothCharacteristic(List<ServiceCharacteristicStruct>? val) =>
      _bluetoothCharacteristic = val;
  void updateBluetoothCharacteristic(
          Function(List<ServiceCharacteristicStruct>) updateFn) =>
      updateFn(_bluetoothCharacteristic ??= []);
  bool hasBluetoothCharacteristic() => _bluetoothCharacteristic != null;

  static ServiceStruct fromMap(Map<String, dynamic> data) => ServiceStruct(
        uuid: data['uuid'] as String?,
        primary: data['primary'] as bool?,
        name: data['name'] as String?,
        bluetoothCharacteristic: getStructList(
          data['bluetoothCharacteristic'],
          ServiceCharacteristicStruct.fromMap,
        ),
      );

  static ServiceStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? ServiceStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'uuid': _uuid,
        'primary': _primary,
        'name': _name,
        'bluetoothCharacteristic':
            _bluetoothCharacteristic?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'uuid': serializeParam(
          _uuid,
          ParamType.String,
        ),
        'primary': serializeParam(
          _primary,
          ParamType.bool,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'bluetoothCharacteristic': serializeParam(
          _bluetoothCharacteristic,
          ParamType.DataStruct,
          true,
        ),
      }.withoutNulls;

  static ServiceStruct fromSerializableMap(Map<String, dynamic> data) =>
      ServiceStruct(
        uuid: deserializeParam(
          data['uuid'],
          ParamType.String,
          false,
        ),
        primary: deserializeParam(
          data['primary'],
          ParamType.bool,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        bluetoothCharacteristic:
            deserializeStructParam<ServiceCharacteristicStruct>(
          data['bluetoothCharacteristic'],
          ParamType.DataStruct,
          true,
          structBuilder: ServiceCharacteristicStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ServiceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ServiceStruct &&
        uuid == other.uuid &&
        primary == other.primary &&
        name == other.name &&
        listEquality.equals(
            bluetoothCharacteristic, other.bluetoothCharacteristic);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([uuid, primary, name, bluetoothCharacteristic]);
}

ServiceStruct createServiceStruct({
  String? uuid,
  bool? primary,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ServiceStruct(
      uuid: uuid,
      primary: primary,
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ServiceStruct? updateServiceStruct(
  ServiceStruct? service, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    service
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addServiceStructData(
  Map<String, dynamic> firestoreData,
  ServiceStruct? service,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (service == null) {
    return;
  }
  if (service.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && service.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final serviceData = getServiceFirestoreData(service, forFieldValue);
  final nestedData = serviceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = service.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getServiceFirestoreData(
  ServiceStruct? service, [
  bool forFieldValue = false,
]) {
  if (service == null) {
    return {};
  }
  final firestoreData = mapToFirestore(service.toMap());

  // Add any Firestore field values
  service.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getServiceListFirestoreData(
  List<ServiceStruct>? services,
) =>
    services?.map((e) => getServiceFirestoreData(e, true)).toList() ?? [];
