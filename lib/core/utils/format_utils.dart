/// Formats a weight in kg with up to 2 decimals, trimming trailing zeros.
String formatWeight(double kg) {
    if (kg == kg.roundToDouble()) {
        return kg == kg.truncateToDouble()
            ? kg.truncate().toString()
            : kg.toStringAsFixed(1);
    }
    final fixed = kg.toStringAsFixed(2);
    if (fixed.endsWith('0')) {
        return fixed.substring(0, fixed.length - 1);
    }
    return fixed;
}

/// Formats a countdown in m:ss (e.g. 90 s -> "1:30").
String formatRestDuration(int seconds) {
    final clamped = seconds < 0 ? 0 : seconds;
    final minutes = clamped ~/ 60;
    final rest = clamped % 60;
    return '$minutes:${rest.toString().padLeft(2, '0')}';
}
