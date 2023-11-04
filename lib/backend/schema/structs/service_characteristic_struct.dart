// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServiceCharacteristicStruct extends FFFirebaseStruct {
  ServiceCharacteristicStruct({
    String? uuid,
    String? serviceUuid,
    String? secondaryServiceUuid,
    CharacteristicPropertiesStruct? properties,
    List<BluetoothDescriptorStruct>? descriptors,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _uuid = uuid,
        _serviceUuid = serviceUuid,
        _secondaryServiceUuid = secondaryServiceUuid,
        _properties = properties,
        _descriptors = descriptors,
        super(firestoreUtilData);

  // "uuid" field.
  String? _uuid;
  String get uuid => _uuid ?? '';
  set uuid(String? val) => _uuid = val;
  bool hasUuid() => _uuid != null;

  // "serviceUuid" field.
  String? _serviceUuid;
  String get serviceUuid => _serviceUuid ?? '';
  set serviceUuid(String? val) => _serviceUuid = val;
  bool hasServiceUuid() => _serviceUuid != null;

  // "secondaryServiceUuid" field.
  String? _secondaryServiceUuid;
  String get secondaryServiceUuid => _secondaryServiceUuid ?? '';
  set secondaryServiceUuid(String? val) => _secondaryServiceUuid = val;
  bool hasSecondaryServiceUuid() => _secondaryServiceUuid != null;

  // "properties" field.
  CharacteristicPropertiesStruct? _properties;
  CharacteristicPropertiesStruct get properties =>
      _properties ?? CharacteristicPropertiesStruct();
  set properties(CharacteristicPropertiesStruct? val) => _properties = val;
  void updateProperties(Function(CharacteristicPropertiesStruct) updateFn) =>
      updateFn(_properties ??= CharacteristicPropertiesStruct());
  bool hasProperties() => _properties != null;

  // "descriptors" field.
  List<BluetoothDescriptorStruct>? _descriptors;
  List<BluetoothDescriptorStruct> get descriptors => _descriptors ?? const [];
  set descriptors(List<BluetoothDescriptorStruct>? val) => _descriptors = val;
  void updateDescriptors(Function(List<BluetoothDescriptorStruct>) updateFn) =>
      updateFn(_descriptors ??= []);
  bool hasDescriptors() => _descriptors != null;

  static ServiceCharacteristicStruct fromMap(Map<String, dynamic> data) =>
      ServiceCharacteristicStruct(
        uuid: data['uuid'] as String?,
        serviceUuid: data['serviceUuid'] as String?,
        secondaryServiceUuid: data['secondaryServiceUuid'] as String?,
        properties:
            CharacteristicPropertiesStruct.maybeFromMap(data['properties']),
        descriptors: getStructList(
          data['descriptors'],
          BluetoothDescriptorStruct.fromMap,
        ),
      );

  static ServiceCharacteristicStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? ServiceCharacteristicStruct.fromMap(data)
          : null;

  Map<String, dynamic> toMap() => {
        'uuid': _uuid,
        'serviceUuid': _serviceUuid,
        'secondaryServiceUuid': _secondaryServiceUuid,
        'properties': _properties?.toMap(),
        'descriptors': _descriptors?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'uuid': serializeParam(
          _uuid,
          ParamType.String,
        ),
        'serviceUuid': serializeParam(
          _serviceUuid,
          ParamType.String,
        ),
        'secondaryServiceUuid': serializeParam(
          _secondaryServiceUuid,
          ParamType.String,
        ),
        'properties': serializeParam(
          _properties,
          ParamType.DataStruct,
        ),
        'descriptors': serializeParam(
          _descriptors,
          ParamType.DataStruct,
          true,
        ),
      }.withoutNulls;

  static ServiceCharacteristicStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ServiceCharacteristicStruct(
        uuid: deserializeParam(
          data['uuid'],
          ParamType.String,
          false,
        ),
        serviceUuid: deserializeParam(
          data['serviceUuid'],
          ParamType.String,
          false,
        ),
        secondaryServiceUuid: deserializeParam(
          data['secondaryServiceUuid'],
          ParamType.String,
          false,
        ),
        properties: deserializeStructParam(
          data['properties'],
          ParamType.DataStruct,
          false,
          structBuilder: CharacteristicPropertiesStruct.fromSerializableMap,
        ),
        descriptors: deserializeStructParam<BluetoothDescriptorStruct>(
          data['descriptors'],
          ParamType.DataStruct,
          true,
          structBuilder: BluetoothDescriptorStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ServiceCharacteristicStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ServiceCharacteristicStruct &&
        uuid == other.uuid &&
        serviceUuid == other.serviceUuid &&
        secondaryServiceUuid == other.secondaryServiceUuid &&
        properties == other.properties &&
        listEquality.equals(descriptors, other.descriptors);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([uuid, serviceUuid, secondaryServiceUuid, properties, descriptors]);
}

ServiceCharacteristicStruct createServiceCharacteristicStruct({
  String? uuid,
  String? serviceUuid,
  String? secondaryServiceUuid,
  CharacteristicPropertiesStruct? properties,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ServiceCharacteristicStruct(
      uuid: uuid,
      serviceUuid: serviceUuid,
      secondaryServiceUuid: secondaryServiceUuid,
      properties: properties ??
          (clearUnsetFields ? CharacteristicPropertiesStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ServiceCharacteristicStruct? updateServiceCharacteristicStruct(
  ServiceCharacteristicStruct? serviceCharacteristic, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    serviceCharacteristic
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addServiceCharacteristicStructData(
  Map<String, dynamic> firestoreData,
  ServiceCharacteristicStruct? serviceCharacteristic,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (serviceCharacteristic == null) {
    return;
  }
  if (serviceCharacteristic.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      serviceCharacteristic.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final serviceCharacteristicData = getServiceCharacteristicFirestoreData(
      serviceCharacteristic, forFieldValue);
  final nestedData =
      serviceCharacteristicData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      serviceCharacteristic.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getServiceCharacteristicFirestoreData(
  ServiceCharacteristicStruct? serviceCharacteristic, [
  bool forFieldValue = false,
]) {
  if (serviceCharacteristic == null) {
    return {};
  }
  final firestoreData = mapToFirestore(serviceCharacteristic.toMap());

  // Handle nested data for "properties" field.
  addCharacteristicPropertiesStructData(
    firestoreData,
    serviceCharacteristic.hasProperties()
        ? serviceCharacteristic.properties
        : null,
    'properties',
    forFieldValue,
  );

  // Add any Firestore field values
  serviceCharacteristic.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getServiceCharacteristicListFirestoreData(
  List<ServiceCharacteristicStruct>? serviceCharacteristics,
) =>
    serviceCharacteristics
        ?.map((e) => getServiceCharacteristicFirestoreData(e, true))
        .toList() ??
    [];
