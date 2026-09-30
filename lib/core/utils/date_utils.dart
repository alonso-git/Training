import 'package:intl/intl.dart';

class AppDateUtils {
    static String formatDateTime(DateTime dt) {
        return DateFormat('EEE, MMM d yyyy · HH:mm').format(dt);
    }

    static String formatDate(DateTime dt) {
        return DateFormat('MMM d, yyyy').format(dt);
    }

    static String formatDuration(Duration d) {
        final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
        final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
        return '${d.inHours}h $mm:$ss';
    }

    static String dayName(int weekdayZeroMonday) {
        return DateFormat.EEEE()
            .dateSymbols
            .WEEKDAYS[(weekdayZeroMonday + 1) % 7];
    }

    static DateTime startOfWeek(DateTime dt) {
        final day = dt.weekday - 1;
        return DateTime(dt.year, dt.month, dt.day - day);
    }
}
