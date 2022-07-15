import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'toast_route.dart' as route;

// ignore: constant_identifier_names
const String TOAST_ROUTE_NAME = '/toastRoute';

typedef ToastStatusCallback = void Function(ToastStatus? status);
typedef OnTap = void Function(Toast toastbar);

/// A highly customizable widget so you can notify your user when you fell like he needs a beautiful explanation.
// ignore: must_be_immutable
class Toast<T> extends StatefulWidget {
  Toast(
      {Key? key,
      this.title,
      this.titleColor,
      this.titleSize,
      this.message,
      this.messageSize,
      this.messageColor,
      this.titleText,
      this.messageText,
      this.icon,
      this.shouldIconPulse = true,
      this.maxWidth,
      this.margin = const EdgeInsets.all(0.0),
      this.padding = const EdgeInsets.all(16),
      this.borderRadius,
      this.textDirection = TextDirection.ltr,
      this.borderColor,
      this.borderWidth = 1.0,
      this.backgroundColor = const Color(0xFF303030),
      this.leftBarIndicatorColor,
      this.boxShadows,
      this.backgroundGradient,
      this.mainButton,
      this.onTap,
      this.duration,
      this.isDismissible = true,
      this.dismissDirection = ToastDismissDirection.VERTICAL,
      this.showProgressIndicator = false,
      this.progressIndicatorController,
      this.progressIndicatorBackgroundColor,
      this.progressIndicatorValueColor,
      this.toastPosition = ToastPosition.BOTTOM,
      this.positionOffset = 0.0,
      this.toastStyle = ToastStyle.FLOATING,
      this.forwardAnimationCurve = Curves.easeOutCirc,
      this.reverseAnimationCurve = Curves.easeOutCirc,
      this.animationDuration = const Duration(seconds: 1),
      ToastStatusCallback? onStatusChanged,
      this.barBlur = 0.0,
      this.blockBackgroundInteraction = false,
      this.routeBlur,
      this.routeColor,
      this.userInputForm,
      this.endOffset,
      this.toastRoute // Please dont init this
      })
      // ignore: prefer_initializing_formals
      : onStatusChanged = onStatusChanged,
        super(key: key) {
    onStatusChanged = onStatusChanged ?? (status) {};
  }

  /// A callback for you to listen to the different toast status
  final ToastStatusCallback? onStatusChanged;

  /// The title displayed to the user
  final String? title;

  /// The title text size displayed to the user
  final double? titleSize;

  /// Color title displayed to the user ? default is black
  final Color? titleColor;

  /// The message displayed to the user.
  final String? message;

  /// The message text size displayed to the user.
  final double? messageSize;

  /// Color message displayed to the user ? default is black
  final Color? messageColor;

  /// Replaces [title]. Although this accepts a [Widget], it is meant to receive [Text] or [RichText]
  final Widget? titleText;

  /// Replaces [message]. Although this accepts a [Widget], it is meant to receive [Text] or  [RichText]
  final Widget? messageText;

  /// Will be ignored if [backgroundGradient] is not null
  final Color backgroundColor;

  /// If not null, shows a left vertical bar to better indicate the humor of the notification.
  /// It is not possible to use it with a [Form] and I do not recommend using it with [LinearProgressIndicator]
  final Color? leftBarIndicatorColor;

  /// [boxShadows] The shadows generated by toast. Leave it null if you don't want a shadow.
  /// You can use more than one if you feel the need.
  /// Check (this example)[https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/shadows.dart]
  final List<BoxShadow>? boxShadows;

  /// Makes [backgroundColor] be ignored.
  final Gradient? backgroundGradient;

  /// You can use any widget here, but I recommend [Icon] or [Image] as indication of what kind
  /// of message you are displaying. Other widgets may break the layout
  final Widget? icon;

  /// An option to animate the icon (if present). Defaults to true.
  final bool shouldIconPulse;

  /// Use if you need an action from the user. [TextButton] is recommended here
  final Widget? mainButton;

  /// A callback that registers the user's click anywhere. An alternative to [mainButton]
  final OnTap? onTap;

  /// How long until toast will hide itself (be dismissed). To make it indefinite, leave it null.
  final Duration? duration;

  /// True if you want to show a [LinearProgressIndicator].
  /// If [progressIndicatorController] is null, an infinite progress indicator will be shown
  final bool showProgressIndicator;

  /// An optional [AnimationController] when you want to control the progress of your [LinearProgressIndicator].
  /// You are responsible for controlling the progress
  final AnimationController? progressIndicatorController;

  /// A [LinearProgressIndicator] configuration parameter.
  final Color? progressIndicatorBackgroundColor;

  /// A [LinearProgressIndicator] configuration parameter.
  final Animation<Color>? progressIndicatorValueColor;

  /// Determines if the user can swipe or click the overlay (if [routeBlur] > 0) to dismiss.
  /// It is recommended that you set [duration] != null if this is false.
  /// If the user swipes to dismiss or clicks the overlay, no value will be returned.
  final bool isDismissible;

  /// Used to limit toast width (usually on large screens)
  final double? maxWidth;

  /// Adds a custom margin to toast
  final EdgeInsets margin;

  /// Adds a custom padding to toast
  /// The default follows material design guide line
  final EdgeInsets padding;

  /// Adds a radius to corners specified of toast. Best combined with [margin].
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final BorderRadius? borderRadius;

  /// [TextDirection.ltr] by default
  /// added to support rtl languages
  final TextDirection textDirection;

  // Adds a border to every side of toast
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final Color? borderColor;

  /// Changes the width of the border if [borderColor] is specified
  final double borderWidth;

  /// toast can be based on [ToastPosition.TOP] or on [ToastPosition.BOTTOM] of your screen.
  /// [ToastPosition.BOTTOM] is the default.
  final ToastPosition toastPosition;

  final double positionOffset;

  /// [ToastDismissDirection.VERTICAL] by default.
  /// Can also be [ToastDismissDirection.HORIZONTAL] in which case both left and right dismiss are allowed.
  final ToastDismissDirection dismissDirection;

  /// toast can be floating or be grounded to the edge of the screen.
  /// If grounded, I do not recommend using [margin] or [borderRadius]. [ToastStyle.FLOATING] is the default
  /// If grounded, I do not recommend using a [backgroundColor] with transparency or [barBlur]
  final ToastStyle toastStyle;

  /// The [Curve] animation used when show() is called. [Curves.easeOut] is default
  final Curve forwardAnimationCurve;

  /// The [Curve] animation used when dismiss() is called. [Curves.fastOutSlowIn] is default
  final Curve reverseAnimationCurve;

  /// Use it to speed up or slow down the animation duration
  final Duration animationDuration;

  /// Default is 0.0. If different than 0.0, blurs only toast's background.
  /// To take effect, make sure your [backgroundColor] has some opacity.
  /// The greater the value, the greater the blur.
  final double barBlur;

  /// Determines if user can interact with the screen behind it
  /// If this is false, [routeBlur] and [routeColor] will be ignored
  final bool blockBackgroundInteraction;

  /// Default is 0.0. If different than 0.0, creates a blurred
  /// overlay that prevents the user from interacting with the screen.
  /// The greater the value, the greater the blur.
  /// It does not take effect if [blockBackgroundInteraction] is false
  final double? routeBlur;

  /// Default is [Colors.transparent]. Only takes effect if [routeBlur] > 0.0.
  /// Make sure you use a color with transparency here e.g. Colors.grey[600].withOpacity(0.2).
  /// It does not take effect if [blockBackgroundInteraction] is false
  final Color? routeColor;

  /// A [TextFormField] in case you want a simple user input. Every other widget is ignored if this is not null.
  final Form? userInputForm;

  /// Offset to be added to the end toast position.
  /// Intended to replace [margin] when you need items below toast to be accessible
  final Offset? endOffset;

  route.ToastRoute<T?>? toastRoute;

  /// Show the toast. Kicks in [ToastStatus.IS_APPEARING] state followed by [ToastStatus.SHOWING]
  Future<T?> show(BuildContext context) async {
    toastRoute = route.showToast<T>(
      context: context,
      toast: this,
    ) as route.ToastRoute<T?>;

    return await Navigator.of(context, rootNavigator: false)
        .push(toastRoute as Route<T>);
  }

  /// Dismisses the toast causing is to return a future containing [result].
  /// When this future finishes, it is guaranteed that toast was dismissed.
  Future<T?> dismiss([T? result]) async {
    // If route was never initialized, do nothing
    if (toastRoute == null) {
      return null;
    }

    if (toastRoute!.isCurrent) {
      toastRoute!.navigator!.pop(result);
      return toastRoute!.completed;
    } else if (toastRoute!.isActive) {
      // removeRoute is called every time you dismiss a toast that is not the top route.
      // It will not animate back and listeners will not detect toastStatus.IS_HIDING or toastStatus.DISMISSED
      // To avoid this, always make sure that toast is the top route when it is being dismissed
      toastRoute!.navigator!.removeRoute(toastRoute!);
    }

    return null;
  }

  /// Checks if the toast is visible
  bool isShowing() {
    if (toastRoute == null) {
      return false;
    }
    return toastRoute!.currentStatus == ToastStatus.SHOWING;
  }

  /// Checks if the toast is dismissed
  bool isDismissed() {
    if (toastRoute == null) {
      return false;
    }
    return toastRoute!.currentStatus == ToastStatus.DISMISSED;
  }

  bool isAppearing() {
    if (toastRoute == null) {
      return false;
    }
    return toastRoute!.currentStatus == ToastStatus.IS_APPEARING;
  }

  bool isHiding() {
    if (toastRoute == null) {
      return false;
    }
    return toastRoute!.currentStatus == ToastStatus.IS_HIDING;
  }

  @override
  State createState() => _ToastState<T?>();
}

class _ToastState<K extends Object?> extends State<Toast<K>>
    with TickerProviderStateMixin {
  final Duration _pulseAnimationDuration = const Duration(seconds: 1);
  final Widget _emptyWidget = const SizedBox();
  final double _initialOpacity = 1.0;
  final double _finalOpacity = 0.4;

  GlobalKey? _backgroundBoxKey;
  ToastStatus? currentStatus;
  AnimationController? _fadeController;
  late Animation<double> _fadeAnimation;
  late bool _isTitlePresent;
  late double _messageTopMargin;
  FocusScopeNode? _focusNode;
  late FocusAttachment _focusAttachment;
  late Completer<Size> _boxHeightCompleter;

  CurvedAnimation? _progressAnimation;

  @override
  void initState() {
    super.initState();

    _backgroundBoxKey = GlobalKey();
    _boxHeightCompleter = Completer<Size>();

    assert(
        widget.userInputForm != null ||
            ((widget.message != null && widget.message!.isNotEmpty) ||
                widget.messageText != null),
        'A message is mandatory if you are not using userInputForm. Set either a message or messageText');

    _isTitlePresent = (widget.title != null || widget.titleText != null);
    _messageTopMargin = _isTitlePresent ? 6.0 : widget.padding.top;

    _configureLeftBarFuture();
    _configureProgressIndicatorAnimation();

    if (widget.icon != null && widget.shouldIconPulse) {
      _configurePulseAnimation();
      _fadeController?.forward();
    }

    _focusNode = FocusScopeNode();
    _focusAttachment = _focusNode!.attach(context);
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    widget.progressIndicatorController?.dispose();

    _focusAttachment.detach();
    _focusNode!.dispose();
    super.dispose();
  }

  void _configureLeftBarFuture() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final keyContext = _backgroundBoxKey!.currentContext;

        if (keyContext != null) {
          final box = keyContext.findRenderObject() as RenderBox;
          _boxHeightCompleter.complete(box.size);
        }
      },
    );
  }

  void _configureProgressIndicatorAnimation() {
    if (widget.showProgressIndicator &&
        widget.progressIndicatorController != null) {
      _progressAnimation = CurvedAnimation(
          curve: Curves.linear, parent: widget.progressIndicatorController!);
    }
  }

  void _configurePulseAnimation() {
    _fadeController =
        AnimationController(vsync: this, duration: _pulseAnimationDuration);
    _fadeAnimation = Tween(begin: _initialOpacity, end: _finalOpacity).animate(
      CurvedAnimation(
        parent: _fadeController!,
        curve: Curves.linear,
      ),
    );

    _fadeController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController!.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _fadeController!.forward();
      }
    });

    _fadeController!.forward();
  }

  //TODO : review EdgeInsets
  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1.0,
      child: Material(
        color: widget.toastStyle == ToastStyle.FLOATING
            ? Colors.transparent
            : widget.backgroundColor,
        child: SafeArea(
          minimum: widget.toastPosition == ToastPosition.BOTTOM
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom +
                      widget.positionOffset)
              : EdgeInsets.only(
                  top: MediaQuery.of(context).viewInsets.top +
                      widget.positionOffset),
          bottom: widget.toastPosition == ToastPosition.BOTTOM,
          top: widget.toastPosition == ToastPosition.TOP,
          left: false,
          right: false,
          child: _gettoast(),
        ),
      ),
    );
  }

  Widget _gettoast() {
    Widget toast;

    if (widget.userInputForm != null) {
      toast = _generateInputtoast();
    } else {
      toast = _generatetoast();
    }

    return Stack(
      children: [
        FutureBuilder(
          future: _boxHeightCompleter.future,
          builder: (context, AsyncSnapshot<Size> snapshot) {
            if (snapshot.hasData) {
              if (widget.barBlur == 0) {
                return _emptyWidget;
              }
              return ClipRRect(
                borderRadius: widget.borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: widget.barBlur, sigmaY: widget.barBlur),
                  child: Container(
                    height: snapshot.data!.height,
                    width: snapshot.data!.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: widget.borderRadius,
                    ),
                  ),
                ),
              );
            }
            return _emptyWidget;
          },
        ),
        toast,
      ],
    );
  }

  Widget _generateInputtoast() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidth != null
          ? BoxConstraints(maxWidth: widget.maxWidth!)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: widget.borderRadius,
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!, width: widget.borderWidth)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, bottom: 8.0, top: 16.0),
        child: FocusScope(
          node: _focusNode,
          autofocus: true,
          child: widget.userInputForm!,
        ),
      ),
    );
  }

  Widget _generatetoast() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidth != null
          ? BoxConstraints(maxWidth: widget.maxWidth!)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: widget.borderRadius,
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!, width: widget.borderWidth)
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressIndicator(),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: _getAppropriateRowLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (widget.showProgressIndicator && _progressAnimation != null) {
      return AnimatedBuilder(
          animation: _progressAnimation!,
          builder: (_, __) {
            return LinearProgressIndicator(
              value: _progressAnimation!.value,
              backgroundColor: widget.progressIndicatorBackgroundColor,
              valueColor: widget.progressIndicatorValueColor,
            );
          });
    }

    if (widget.showProgressIndicator) {
      return LinearProgressIndicator(
        backgroundColor: widget.progressIndicatorBackgroundColor,
        valueColor: widget.progressIndicatorValueColor,
      );
    }

    return _emptyWidget;
  }

  List<Widget> _getAppropriateRowLayout() {
    double buttonRightPadding;
    var iconPadding = 0.0;
    if (widget.padding.right - 12 < 0) {
      buttonRightPadding = 4;
    } else {
      buttonRightPadding = widget.padding.right - 12;
    }

    if (widget.padding.left > 16.0) {
      iconPadding = widget.padding.left;
    }

    if (widget.icon == null && widget.mainButton == null) {
      return [
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: widget.padding.left,
                        right: widget.padding.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon != null && widget.mainButton == null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: 4.0,
                        right: widget.padding.left,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4.0,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon == null && widget.mainButton != null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: widget.padding.left,
                        right: widget.padding.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: 8.0,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: buttonRightPadding),
          child: _getMainActionButton(),
        ),
      ];
    } else {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: 4.0,
                        right: 8.0,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4.0,
                  right: 8.0,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        _getMainActionButton() != null
            ? Padding(
                padding: EdgeInsets.only(right: buttonRightPadding),
                child: _getMainActionButton(),
              )
            : _emptyWidget,
      ];
    }
  }

  Widget _buildLeftBarIndicator() {
    if (widget.leftBarIndicatorColor != null) {
      return FutureBuilder(
        future: _boxHeightCompleter.future,
        builder: (BuildContext buildContext, AsyncSnapshot<Size> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: 8.0,
              height: snapshot.data!.height,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius == null
                    ? null
                    : widget.textDirection == TextDirection.ltr
                        ? BorderRadius.only(
                            topLeft: widget.borderRadius!.topLeft,
                            bottomLeft: widget.borderRadius!.bottomLeft)
                        : BorderRadius.only(
                            topRight: widget.borderRadius!.topRight,
                            bottomRight: widget.borderRadius!.bottomRight),
                color: widget.leftBarIndicatorColor,
              ),
            );
          } else {
            return _emptyWidget;
          }
        },
      );
    } else {
      return _emptyWidget;
    }
  }

  Widget? _getIcon() {
    if (widget.icon != null && widget.icon is Icon && widget.shouldIconPulse) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: widget.icon,
      );
    } else if (widget.icon != null) {
      return widget.icon;
    } else {
      return _emptyWidget;
    }
  }

  Widget? _getTitleText() {
    return widget.titleText ??
        Text(
          widget.title ?? '',
          style: TextStyle(
              fontSize: widget.titleSize ?? 16.0,
              color: widget.titleColor ?? Colors.white,
              fontWeight: FontWeight.bold),
        );
  }

  Text _getDefaultNotificationText() {
    return Text(
      widget.message ?? '',
      style: TextStyle(
          fontSize: widget.messageSize ?? 14.0,
          color: widget.messageColor ?? Colors.white),
    );
  }

  Widget? _getMainActionButton() {
    if (widget.mainButton != null) {
      return widget.mainButton;
    } else {
      return null;
    }
  }
}

/// Indicates if toast is going to start at the [TOP] or at the [BOTTOM]
enum ToastPosition { TOP, BOTTOM }

/// Indicates if toast will be attached to the edge of the screen or not
enum ToastStyle { FLOATING, GROUNDED }

/// Indicates the direction in which it is possible to dismiss
/// If vertical, dismiss up will be allowed if [ToastPosition.TOP]
/// If vertical, dismiss down will be allowed if [ToastPosition.BOTTOM]
enum ToastDismissDirection { HORIZONTAL, VERTICAL }

/// Indicates the animation status
/// [ToastStatus.SHOWING] toast has stopped and the user can see it
/// [ToastStatus.DISMISSED] toast has finished its mission and returned any pending values
/// [ToastStatus.IS_APPEARING] toast is moving towards [ToastStatus.SHOWING]
/// [ToastStatus.IS_HIDING] toast is moving towards [] [ToastStatus.DISMISSED]
enum ToastStatus { SHOWING, DISMISSED, IS_APPEARING, IS_HIDING }
