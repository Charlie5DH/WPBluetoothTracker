import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

bool? showSearchResults(
  String? nameSearchFor,
  String? nameSearching,
) {
  return nameSearching?.toLowerCase().contains(nameSearchFor as Pattern);
}

String? buildLocalizationMessage(
  String? latitude,
  String? longitude,
) {
  return 'LatLng(lat: $latitude, lng: $longitude)';
}

String? beautifyCSVLine(String? line) {
  // takes a comma separated line (x1,x2,x3) and returns a line in the format:
  // x1 | x2 | x3
  final splitLine = line?.split(',');
  final beautifiedLine = splitLine?.join(' | ');
  return "-> $beautifiedLine";
}

List<BTDevicesStruct> sortDevices(
  String? sortBy,
  List<BTDevicesStruct> scannedDevices,
) {
  /*MODIFY CODE ONLY BELOW THIS LINE
    BTDevicesStruct is a custom struct of the format
    {
      String name;
      String id;
      int rssi;
    }
    the function should return the list sorted by the sortBy parameter
    the possibilites for sorting are STC-STS, STS-STC, RSSI
    STC-STS = Sort by device name starting with STC, then STS, then everything else
    STS-STC = Sort by device name starting with STS, then STC, then everything else
    RSSI = Sort by signal strength
   */

  if (sortBy == "STS-STC" || sortBy == "STC-STS") {
    List startsWithSTS = [];
    List startsWithSTC = [];
    List otherObjects = [];

    for (var obj in scannedDevices) {
      if (obj.name.startsWith("STS")) {
        startsWithSTS.add(obj);
      } else if (obj.name.startsWith("STC")) {
        startsWithSTC.add(obj);
      } else {
        otherObjects.add(obj);
      }
    }
    startsWithSTS.sort((a, b) => a.name.compareTo(b.name));
    startsWithSTC.sort((a, b) => a.name.compareTo(b.name));
    otherObjects.sort((a, b) => a.name.compareTo(b.name));

    if (sortBy == "STS-STC") {
      return [...startsWithSTS, ...startsWithSTC, ...otherObjects];
    } else {
      return [...startsWithSTC, ...startsWithSTS, ...otherObjects];
    }
  } else if (sortBy == "RSSI") {
    scannedDevices.sort((a, b) => b.rssi.compareTo(a.rssi));
    return scannedDevices;
  } else {
    // If sortingParam is not "STS," sort the list without any changes.
    scannedDevices.sort((a, b) => a.name.compareTo(b.name));
    return scannedDevices;
  }
}

List<BTDevicesStruct> filterItemsInFoundDevicesList(
  List<BTDevicesStruct> connectedDevices,
  List<BTDevicesStruct> foundDevices,
) {
// remove all devices that are already connected from the list of found devices
  for (int i = 0; i < connectedDevices.length; i++) {
    final deviceResult = connectedDevices[i];
    // if the device is already connected, remove it from the list of devices
    foundDevices.removeWhere((element) => element.id == deviceResult.id);
  }
  return foundDevices;
}

bool? isConnectedDeviceInList(
  List<BTDevicesStruct> connectedDevices,
  BTDevicesStruct? device,
) {
  /// The function receives a list of connected devices and a device to check
  /// If the device is in the list, return true, else return false

  for (var obj in connectedDevices) {
    if (obj.id == device?.id) {
      return true;
    }
  }
  return false;
}

bool? isSTS(String? deviceName) {
  // returns true if the device name starts with STS,
  // else returns false
  if (deviceName?.startsWith("STS") == true) {
    return true;
  } else {
    return false;
  }
}

bool? isSTC(String? deviceName) {
  // returns true if the device name starts with STS,
  // else returns false
  if (deviceName?.startsWith("STC") == true ||
      deviceName?.startsWith("stc") == true) {
    return true;
  } else {
    return false;
  }
}

bool hasDegreeSymbol(String text) {
  // returns true if the text contains the degree symbol,
  // else returns false
  // first convert the text to utf8

  if (text.contains("°")) {
    return true;
  } else {
    return false;
  }
}

String formatLatLng(String latitude, String longitude) {
  // format the latitude and longitude from
  // LatLng(lat: double, lng: double) to
  // lat: double, lng: double
  // with 6 decimal places
  latitude = latitude.substring(
      0,
      latitude.indexOf('.') + 7 >= latitude.length
          ? latitude.length
          : latitude.indexOf('.') + 7);
  longitude = longitude.substring(
      0,
      longitude.indexOf('.') + 7 >= longitude.length
          ? longitude.length
          : longitude.indexOf('.') + 7);
  return 'lat: ' + latitude + ', lng: ' + longitude;
}

int? castStringToNumber(String? textNumber) {
  /// castStringToNumber takes a string and returns an integer
  /// if the string is not a number, it returns null

  try {
    return int.parse(textNumber as String);
  } catch (e) {
    return null;
  }
}
