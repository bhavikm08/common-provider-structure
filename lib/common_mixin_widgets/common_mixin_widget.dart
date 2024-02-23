import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tuple/tuple.dart';

typedef ValidationRule = Tuple2<String, String>;

mixin CommonWidgets {
  Future<void> commonToast({
    required String errorMessage,
    Toast? toastLength,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    ToastGravity? toastGravity,
  }) {
    return Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: toastGravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.red,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? 15.0,
    );
  }

  Future<void> commonShowErrorDialog({
    required BuildContext context,
    required String message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close),
                ),
                const Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                commonElevatedButton(
                  buttonText: "Ok",
                  buttonOnTap: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> commonConfirmationDialog({
    required BuildContext context,
    String? message,
    required Function onYes,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Delete Selected?',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    message ?? "This action will permanently delete the selected item. Are you sure you want to proceed ?",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.0),
                                            child: Icon(Icons.close,
                                                color: Colors.white,
                                                size: 18))),
                                    TextSpan(
                                        text: "Cancel",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onYes,
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.0),
                                            child: Icon(Icons.delete,
                                                color: Colors.white,
                                                size: 18))),
                                    TextSpan(
                                        text: "Delete",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      commonSnackBar(
          {required BuildContext context,
          required String message,
          Color? snackBarActionBackgroundColor,
          Color? actionDisabledBackground,
          Color? backgroundColor,
          Color? actionTextColor,
          Color? actionDisabledTextColor,
          String? snackBarActionLabel,
          Function? snackBarActionFunction,
          EdgeInsetsGeometry? margin,
          EdgeInsetsGeometry? padding,
          SnackBarBehavior? snackBarBehavior,
          bool actionNeed = false,
          ShapeBorder? shape}) async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: const TextStyle(
            color: Colors.white,
          )),
      backgroundColor: backgroundColor,
      action: !actionNeed
          ? null
          : SnackBarAction(
              backgroundColor: snackBarActionBackgroundColor,
              disabledBackgroundColor: actionDisabledBackground,
              textColor: actionTextColor,
              disabledTextColor: actionDisabledTextColor,
              label: snackBarActionLabel ?? "",
              onPressed: () => snackBarActionFunction?.call(),
            ),
      margin: margin,
      padding: padding,
      shape: shape,
      elevation: 0,
      duration: const Duration(seconds: 2),
      behavior: snackBarBehavior ?? SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.down,
    ));
  }

  // commonLoader({required BuildContext context, required bool showLoader}) async {
  //   if (showLoader) {
  //     return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(
  //             backgroundColor: Colors.black,
  //             valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
  //             strokeWidth: 3,
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }
  //
  // Future<void> commonLoader(
  //     {required BuildContext context, required bool showLoader}) async {
  //   if (showLoader) {
  //     await showLoader;
  //   } else {
  //     Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  //   }
  // }

  // Future<void> showLoader(BuildContext context, {bool isBarrierDismissible = true}) async {
  //   Completer<void> completer = Completer<void>();
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: isBarrierDismissible,
  //     builder: (BuildContext context) {
  //       return const AlertDialog(
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             CircularProgressIndicator(),
  //             SizedBox(height: 10),
  //             Text('Loading...'),
  //           ],
  //         ),
  //       );
  //     },
  //   ).then((_) {
  //     completer.complete(); // Signal that the asynchronous task is complete
  //   });
  //
  //   // Simulate an asynchronous task
  //   await Future.delayed(Duration(seconds: 3));
  //
  //   Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  //
  //   return completer.future;

  static OverlayEntry? _overlayEntry;

  commonLoader(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _overlayEntry = OverlayEntry(
        builder: (context) => _buildLoader(),
      );

      Overlay.of(context).insert(_overlayEntry!);
    });
  }


  hideLoader() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  _buildLoader() {
    return IgnorePointer(
      ignoring: false,
      child: Container(
        color: Colors.black.withOpacity(0.1),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          backgroundColor: Colors.black,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget commonText(
      {required String commonText,
      TextOverflow? textOverflow,
      Color? color,
      TextAlign? textAlign,
      String? fontFamily,
      TextDecoration? textDecoration,
      double? fontSize,
      FontStyle? fontStyle,
      double? height,
      FontWeight? fontWeight,
      Function? textOnTap,
      Function? textOnLongPress,
      TextOverflow? overflow,
      double? wordSpacing,
      int? maxLines,
      bool? softWrap,
      bool textOnTapUse = false,
      TextLeadingDistribution? leadingDistribution}) {
    return InkWell(
      onLongPress: () => !textOnTapUse ? null : textOnLongPress?.call(),
      onTap: () => !textOnTapUse ? null : textOnTap?.call(),
      child: Text(
        commonText,
        overflow: textOverflow,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        style: TextStyle(
          fontFamily: fontFamily,
          color: color,
          decoration: textDecoration,
          fontSize: fontSize,
          fontStyle: fontStyle,
          height: height,
          fontWeight: fontWeight,
          overflow: overflow,
          wordSpacing: wordSpacing,
          leadingDistribution: leadingDistribution,
        ),
        textScaleFactor: 1.0,
      ),
    );
  }

  Widget commonElevatedButton({
    required String buttonText,
    required Function buttonOnTap,
    // required BuildContext context,
    void Function(bool)? onFocusChange,
    FontWeight? fontWeight,
    Color? buttonTextColor,
    String? fontFamily,
    FontStyle? fontStyle,
    TextBaseline? textBaseline,
    TextOverflow? textOverflow,
    double? textFontSize,
    TextDecoration? textDecoration,
    FocusNode? focusNode,
    Color? buttonBackgroundColor,
    double? buttonHeight,
  }) {
    return ElevatedButton(
        focusNode: focusNode,
        // onFocusChange: (value) => onFocusChange,
        onFocusChange: (bool hasFocus) => onFocusChange?.call(hasFocus),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(buttonBackgroundColor),
          alignment: Alignment.center,
          textStyle: MaterialStatePropertyAll(TextStyle(
            fontWeight: fontWeight,
            color: buttonTextColor,
            fontFamily: fontFamily,
            fontStyle: fontStyle,
            textBaseline: textBaseline,
            overflow: textOverflow,
            fontSize: textFontSize,
            decoration: textDecoration,
          )),
          fixedSize: MaterialStatePropertyAll(
              Size(double.maxFinite, buttonHeight ?? 00)),
          shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
        ),
        onPressed: () => buttonOnTap.call(),
        child: Text(
          buttonText,
        ));
  }

  Future commonBottomSheet(
      {required BuildContext context,
      required Widget widget,
      Color? backgroundColor,
      bool useSafeArea = false,
      bool isScrollControlled = false,
      bool isDismissible = true,
      bool enableDrag = false,
      ShapeBorder? shapeBorder,
      Color? barrierColor,
      String? barrierLabel}) {
    return showModalBottomSheet(
      backgroundColor: backgroundColor,
      useSafeArea: useSafeArea,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: shapeBorder,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      context: context,
      builder: (context) {
        return widget;
      },
    );
  }

  Widget commonContainerButton({
    required Function onTap,
    required String buttonText,
    Function? onLongPress,
    Color? backGroundColor,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? height,
    double? width,
    double? rightMargin,
    double? leftMargin,
    double? topMargin,
    double? bottomMargin,
  }) {
    return GestureDetector(
      onTap: () => onTap.call(),
      onLongPress: () => onLongPress?.call(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backGroundColor ?? Colors.blue,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        padding: padding ?? const EdgeInsets.only(top: 10, bottom: 10),
        margin: margin ??
            EdgeInsets.only(
                right: rightMargin ?? 20,
                left: leftMargin ?? 20,
                top: topMargin ?? 0,
                bottom: bottomMargin ?? 0),
        height: height,
        width: width,
        child: Text(buttonText,
            style: TextStyle(
              color: textColor ?? Colors.white,
            )),
      ),
    );
  }

  Widget commonTextFormField({
    required BuildContext context,
    Widget? suffixIcon,
    Icon? prefixIcon,
    String? hintText,
    Widget? suffixWidget,
    Widget? prefixWidget,
    TextInputAction? textInputAction,
    TextEditingController? textFieldController,
    Function? validation,
    TextInputType? keyboardType,
    bool allowValidation = true,
    bool obscureText = false,
    String? errorMessage,
    String? valueMessage,
    int? length,
    String? initialVal,
    int? value,
    String? lengthMessage,
    String? validationRegex,
    String? validationMessage,
    String? emptyMessage,
    String? containMessage,
    String? returnContainMessage,
    String? passwordMessage,
    Function? suffixIconOnTap,
    String? labelText,
    Function? textFieldCallback,
    Function? onChanged,
    Function? onFieldSubmitted,
    Function? onEditingComplete,
    FocusNode? focusNode,
    TextEditingController? comparisonController,
    String? comparisonErrorMessage,
    String? regexContain,
    String? anotherRegexContain,
    Color? textFieldInputColor,
    String? regexContainErrorMessage,
    String? anotherRegexContainErrorMessage,
    List<ValidationRule>? validationRules,
    bool readOn = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (text) {
          if (textFieldController!.text.trim().isEmpty && allowValidation) {
            return errorMessage ?? "Invalid Input";
          } else if (value != null &&
              (int.parse(textFieldController.text.trim()) > value)) {
            return valueMessage ?? "Invalid Input";
          } else if (length != null && lengthMessage != null) {
            if (textFieldController.text.trim().length < length ||
                textFieldController.text.trim().length > length) {
              return lengthMessage;
            }
          } else if (validationRegex != null) {
            if (!RegExp(validationRegex).hasMatch(text!.trim())) {
              return validationMessage ?? 'Invalid Input';
            }
          } else if (comparisonController != null &&
              textFieldController.text.trim() !=
                  comparisonController.text.trim()) {
            return comparisonErrorMessage ?? 'Fields do not match';
          } else if (validationRules != null) {
            for (var rule in validationRules) {
              final regex = rule.item1;
              if (!RegExp(regex).hasMatch(text!.trim())) {
                return rule.item2;
              }
            }
          }
          return null;
        },
        keyboardType: keyboardType,
        style: TextStyle(color: textFieldInputColor),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: textInputAction,
        controller: textFieldController,
        initialValue: initialVal,
        obscureText: obscureText,
        focusNode: focusNode,
        readOnly: readOn,
        onEditingComplete: () {
          onEditingComplete?.call();
        },
        onFieldSubmitted: (value) {
          onFieldSubmitted?.call(value);
        },
        onTap: () {
          textFieldCallback?.call();
        },
        onChanged: (value) {
          onChanged?.call(value);
        },
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            suffixIcon: suffixIcon,
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffix: suffixWidget,
            prefix: prefixWidget,
            // fillColor: ,
            filled: true,
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color(0x993C3C43),
                fontSize: 16,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
