import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toast/toast.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Toast packgrage', () {
    test('Test Toast basic inicialization', () {
      final toast = Toast(message: 'Test Toast basic inicialization');
      expect(toast.title, null);
      expect(toast.message, 'Test Toast basic inicialization');
      expect(toast.duration, null);
      expect(toast.backgroundColor, const Color(0xFF303030));
      expect(toast.toastPosition, ToastPosition.BOTTOM);
      expect(toast.toastStyle, ToastStyle.FLOATING);
      expect(toast.forwardAnimationCurve, Curves.easeOutCirc);
      expect(toast.reverseAnimationCurve, Curves.easeOutCirc);
      expect(toast.titleText, null);
      expect(toast.messageText, null);
      expect(toast.icon, null);
      expect(toast.leftBarIndicatorColor, null);
      expect(toast.boxShadows, null);
      expect(toast.backgroundGradient, null);
      expect(toast.mainButton, null);
      expect(toast.borderRadius, null);
      expect(toast.borderWidth, 1.0);
      expect(toast.borderColor, null);
      expect(toast.padding.left, 16);
      expect(toast.padding.right, 16);
      expect(toast.padding.top, 16);
      expect(toast.padding.bottom, 16);
      expect(toast.margin.left, 0);
      expect(toast.margin.right, 0);
      expect(toast.margin.top, 0);
      expect(toast.margin.bottom, 0);
      expect(toast.onTap, null);
      expect(toast.isDismissible, true);
      expect(toast.dismissDirection, ToastDismissDirection.VERTICAL);
      expect(toast.showProgressIndicator, false);
      expect(toast.progressIndicatorController, null);
      expect(toast.progressIndicatorBackgroundColor, null);
      expect(toast.progressIndicatorValueColor, null);
      expect(toast.routeBlur, null);
      expect(toast.routeColor, null);
    });
  });
}
