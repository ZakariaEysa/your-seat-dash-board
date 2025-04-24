import '../schedule_item.dart';


class ScheduleValidator {
  static String? validateFields({
    required String? room,
    required String? movie,
    required String? startDate,
    required String? startTime,
    required String? endDate,
    required String? endTime,
    required ScheduleItem originalItem,
  }) {
    if (room == null || movie == null || startDate == null || startTime == null || endDate == null || endTime == null) {
      return "Please fill in all fields ❗";
    }

    final startDateTime = combineDateTime(startDate, startTime);
    final endDateTime = combineDateTime(endDate, endTime);
    final now = DateTime.now();

    if (startDateTime == null || endDateTime == null) {
      return "Invalid date or time format ❌";
    }

    if (startDateTime.isBefore(now)) {
      return "Start time must be in the future ⏳";
    }

    if (endDateTime.isBefore(now)) {
      return "End time must be in the future ⏳";
    }

    if (!startDateTime.isBefore(endDateTime)) {
      return "Start time must be before end time ⏱️";
    }

    if (room == originalItem.room &&
        movie == originalItem.movie &&
        startDate == originalItem.startDate &&
        startTime == originalItem.startTime &&
        endDate == originalItem.endDate &&
        endTime == originalItem.endTime) {
      return "No changes were made ℹ️";
    }

    return null;
  }

  static DateTime? combineDateTime(String? date, String? time) {
    if (date == null || time == null) return null;
    try {
      final dateParts = date.split('/');
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      final timeParts = time.split(' ');
      final hm = timeParts[0].split(':');
      final amPm = timeParts[1];

      int hour = int.parse(hm[0]);
      final minute = int.parse(hm[1]);

      if (amPm.toUpperCase() == 'PM' && hour != 12) hour += 12;
      if (amPm.toUpperCase() == 'AM' && hour == 12) hour = 0;

      return DateTime(year, month, day, hour, minute);
    } catch (_) {
      return null;
    }
  }
}
