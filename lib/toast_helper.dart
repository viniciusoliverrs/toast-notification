import 'package:flutter/material.dart';

import 'toast.dart';

class ToastHelper {
  /// Get a success notification toast.
  static Toast createSuccess(
      {required String message,
      String? title,
      Duration duration = const Duration(seconds: 3)}) {
    return Toast(
      title: title,
      message: message,
      icon: Icon(
        Icons.check_circle,
        color: Colors.green[300],
      ),
      leftBarIndicatorColor: Colors.green[300],
      duration: duration,
    );
  }

  /// Get an information notification toast
  static Toast createInformation(
      {required String message,
      String? title,
      Duration duration = const Duration(seconds: 3)}) {
    return Toast(
      title: title,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      leftBarIndicatorColor: Colors.blue[300],
      duration: duration,
    );
  }

  /// Get a error notification toast
  static Toast createError(
      {required String message,
      String? title,
      Duration duration = const Duration(seconds: 3)}) {
    return Toast(
      title: title,
      message: message,
      icon: Icon(
        Icons.warning,
        size: 28.0,
        color: Colors.red[300],
      ),
      leftBarIndicatorColor: Colors.red[300],
      duration: duration,
    );
  }

  /// Get a toast that can receive a user action through a button.
  static Toast createAction(
      {required String message,
      required Widget button,
      String? title,
      Duration duration = const Duration(seconds: 3)}) {
    return Toast(
      title: title,
      message: message,
      duration: duration,
      mainButton: button,
    );
  }

  // Get a toast that shows the progress of a async computation.
  static Toast createLoading(
      {required String message,
      required LinearProgressIndicator linearProgressIndicator,
      String? title,
      Duration duration = const Duration(seconds: 3),
      AnimationController? progressIndicatorController,
      Color? progressIndicatorBackgroundColor}) {
    return Toast(
      title: title,
      message: message,
      icon: Icon(
        Icons.cloud_upload,
        color: Colors.blue[300],
      ),
      duration: duration,
      showProgressIndicator: true,
      progressIndicatorController: progressIndicatorController,
      progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
    );
  }

  /// Get a toast that shows an user input form.
  static Toast createInputtoast({required Form textForm}) {
    return Toast(
      duration: null,
      userInputForm: textForm,
    );
  }
}
