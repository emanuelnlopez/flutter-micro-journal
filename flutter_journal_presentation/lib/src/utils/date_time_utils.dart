import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class DateTimeUtils {
  static const fullDateTimeFormat = 'dd/MM/yyyy HH:mm:ss';

  static DateFormat geDateFormat(String format) => DateFormat(format);

  static DateTime uuidToDateTime(String uuidString) {
    // Parse the UUID string
    var uuid = Uuid.parse(uuidString);

    // Extract the timestamp (60 bits starting at index 0)
    var timestamp = ((uuid[0] & 0xFFF) << 48) |
        (uuid[1] << 40) |
        (uuid[2] << 32) |
        (uuid[3] << 24) |
        (uuid[4] << 16) |
        (uuid[5] << 8) |
        uuid[6];

    // Adjust for UUID epoch (100-nanosecond intervals since October 15, 1582)
    var milliseconds = (timestamp ~/ 10000) - 12219292800000;

    // Create DateTime object
    return DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
  }
}
