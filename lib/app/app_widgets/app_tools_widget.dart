import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../app_styles/app_constant_file/app_colors.dart';
import 'custom_card_widget.dart';
class ToolsWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;

  const ToolsWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight;
        final iconSize = cardHeight * 0.3;
        final fontSize = cardHeight * 0.085;

        return SizedBox(
          height: cardHeight,
          child: CustomCard(
            margin: const EdgeInsets.only(bottom: 8.0),
            onPressed: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.greenLight,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      height: iconSize * 0.6,
                      width: iconSize * 0.6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                    color: Colors.black87,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}