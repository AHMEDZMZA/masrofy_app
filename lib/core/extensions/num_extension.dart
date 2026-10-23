import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget.allPadding - Widget.horizontalPadding - Widget.verticalPadding - Widget.radius
extension NumExtension on num {
  EdgeInsets get allPadding => EdgeInsets.all(r);

  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: r);

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: r);

  BorderRadius get radius => BorderRadius.circular(r);
}
