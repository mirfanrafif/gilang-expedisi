import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GilangDateUtils {
  static String getTanggalPemesanan(
      DateTime tanggalPemesanan, BuildContext context) {
    // initializeDateFormatting('id_ID', filePath)
    return DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString())
        .format(tanggalPemesanan);
  }
}
