import '../../../rooming_sechduling/presentation/widgets/schedule_item.dart';

class RoomingValidator {
  static String? validateScheduleItems(List<ScheduleItem> items) {
    for (var item in items) {
      final startDateTime = _parseDateTime(item.startDate, item.startTime);
      final endDateTime = _parseDateTime(item.endDate, item.endTime);

      if (startDateTime == null || endDateTime == null) {
        return 'Invalid date/time format.';
      }

      if (!startDateTime.isBefore(endDateTime)) {
        return 'Start date/time must be before end date/time.';
      }
    }
    return null;
  }

  static DateTime? _parseDateTime(String date, String time) {
    try {
      final dateParts = date.contains('-') ? date.split('-') : date.split('/');
      int day, month, year;

      if (date.contains('-')) {
        year = int.parse(dateParts[0]);
        month = int.parse(dateParts[1]);
        day = int.parse(dateParts[2]);
      } else {
        day = int.parse(dateParts[0]);
        month = int.parse(dateParts[1]);
        year = int.parse(dateParts[2]);
      }

      final timeParts = time.trim().split(RegExp(r'[:\s]+'));
      int hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final meridian = timeParts.length == 3 ? timeParts[2].toUpperCase() : "";

      if (meridian == "PM" && hour < 12) {
        hour += 12;
      } else if (meridian == "AM" && hour == 12) {
        hour = 0;
      }

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      return null;
    }
  }
}
