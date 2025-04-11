import 'package:ecommerce_app/core/resources/app_colors.dart';
import 'package:ecommerce_app/core/resources/app_text.dart';
import 'package:ecommerce_app/core/resources/constans.dart';
import 'package:flutter/material.dart';

class UserComment extends StatelessWidget {
  const UserComment({super.key, this.commentData});

  final Map<String, dynamic>? commentData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppText(
              text: commentData?['user_name'] ?? Constans.userNameText,
              color: AppColors.kBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: [
            AppText(
              text: commentData?['comment'] ?? Constans.commentHintText,
              color: AppColors.kBlackColor,
              fontSize: 16,
            ),
          ],
        ),
        commentData?['replay'] != null
            ? Column(
              children: [
                Row(
                  children: [
                    AppText(
                      text: Constans.replyText,
                      color: AppColors.kBlackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ],
                ),
                Row(
                  children: [
                    AppText(
                      text: commentData?['replay'] ?? Constans.replyText,
                      color: AppColors.kBlackColor,
                      fontSize: 16,
                    ),
                  ],
                ),
              ],
            )
            : Container(),
      ],
    );
  }
}
