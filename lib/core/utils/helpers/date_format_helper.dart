class DateFormatHelper {
  DateFormatHelper._();

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// Formats a [DateTime] as `MMM d, yyyy – h:mm AM/PM`.
  ///
  /// Example: `Apr 22, 2026 – 3:45 PM`
  static String formatDateTime(DateTime dateTime) {
    final hour =
        dateTime.hour > 12
            ? dateTime.hour - 12
            : (dateTime.hour == 0 ? 12 : dateTime.hour);
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '${_months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}'
        ' – $hour:$minute $amPm';
  }
}
