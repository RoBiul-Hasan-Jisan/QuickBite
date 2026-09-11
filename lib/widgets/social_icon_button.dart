import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

class SocialIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffold,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(assetPath),
          ),
        ),
      ),
    );
  }
}
