import 'package:easy_localization/easy_localization.dart';
import 'package:masrofy/features/home/controllers/reports_provider.dart';

extension ReportsFilterExtension on ReportsFilter {
  String get name {
    switch (this) {
      case ReportsFilter.thisMonth:
        return 'filter_this_month'.tr();
      case ReportsFilter.lastMonth:
        return 'filter_last_month'.tr();
      case ReportsFilter.thisYear:
        return 'filter_this_year'.tr();
      case ReportsFilter.all:
        return 'filter_all'.tr();
    }
  }
}
