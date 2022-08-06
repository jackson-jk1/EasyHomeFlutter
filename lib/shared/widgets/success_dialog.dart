import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_elevated_button.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    Key? key,
    required this.message,
    this.messageDetail,
  }) : super(key: key);

  final String message;
  final String? messageDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width * 0.9,
          height: Get.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Material(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 92,
                        color: Colors.green,
                      ),
                      Text(
                        "Sucesso!",
                        style: Get.textTheme.headline1!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        message,
                        style: Get.textTheme.bodyText1!.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      messageDetail != null
                          ? Text(
                              messageDetail!,
                              style: Get.textTheme.bodyText1!
                                  .copyWith(fontSize: 14),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Column(
                    children: [
                      CustomElevatedButton(
                          onPressed: Get.back,
                          textButton: 'OK',
                          textColor: Colors.white,
                          buttonColor: Colors.green,
                          width: Get.width * 0.7,
                          height: Get.height * 0.04),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
