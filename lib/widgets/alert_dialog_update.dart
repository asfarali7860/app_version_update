import 'package:app_version_update/app_version_update.dart';
import 'package:app_version_update/data/models/app_version_result.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// ```AppVersionUpdate.showAlertUpdate()``` AlertDialog widget
// ignore: must_be_immutable
class UpdateVersionDialog extends Container {
  String? title;
  String? content;
  bool mandatory, updated;
  String? updateButtonText;
  String? cancelButtonText;
  ButtonStyle? updateButtonStyle;
  ButtonStyle? cancelButtonStyle;
  AppVersionResult? appVersionResult;
  Color? backgroundColor;
  TextStyle? titleTextStyle;
  TextStyle? contentTextStyle;
  TextStyle? cancelTextStyle;
  TextStyle? updateTextStyle;

  UpdateVersionDialog({
    this.title,
    this.content,
    this.mandatory = false,
    this.updated = false,
    this.updateButtonText,
    this.cancelButtonText,
    this.updateButtonStyle,
    this.updateTextStyle,
    this.appVersionResult,
    this.backgroundColor,
    this.cancelButtonStyle,
    this.cancelTextStyle,
    this.contentTextStyle,
    this.titleTextStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor!,
      title: Text(
        title!,
        style: titleTextStyle ??
            const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
      ),
      content: Text(
        content!,
        style: contentTextStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: mandatory && !updated
              ? const SizedBox.shrink()
              : GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 52,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF6C018A)),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text(
                      cancelButtonText!,
                      style: const TextStyle(
                        color: Color(0xFF6c018A), fontWeight: FontWeight.w600, fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              await launchUrl(
                Uri.parse(
                  appVersionResult!.storeUrl!,
                ),
                mode: LaunchMode.externalApplication,
              );
              if (mandatory && !updated) {
                await AppVersionUpdate.checkForUpdates(
                  appleId: appVersionResult!.appleId,
                  playStoreId: appVersionResult!.playStoreId,
                ).then((checkIfUpdated) {
                  if (!checkIfUpdated.canUpdate!) {
                    updated = true;
                  }
                });
              }
            },
            child: Container(
                height: 52,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF6C018A),
                      Color(0xFF00183C),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    updateButtonText!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ),
        ),
      ],
    );
  }
}
