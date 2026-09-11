import 'package:flutter/material.dart';

import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../../widgets/settings_tile.dart';
import '../auth/login_screen.dart';
import 'addresses_screen.dart';
import 'edit_profile_screen.dart';
import 'notifications_screen.dart';
import 'payment_methods_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 32, backgroundImage: AssetImage(AppAssets.avatar)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Alex Rivera', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      SizedBox(height: 2),
                      Text('alex.rivera@email.com',
                          style: TextStyle(color: AppColors.textBody, fontSize: 13)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: AppColors.primaryDark),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('Account', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: AppSpacing.sm),
            SettingsTile(
              icon: Icons.location_on_outlined,
              title: 'Delivery addresses',
              subtitle: 'Manage saved addresses',
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const AddressesScreen())),
            ),
            const SizedBox(height: AppSpacing.sm),
            SettingsTile(
              icon: Icons.credit_card_rounded,
              title: 'Payment methods',
              subtitle: 'Manage cards',
              iconColor: AppColors.success,
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const PaymentMethodsScreen())),
            ),
            const SizedBox(height: AppSpacing.sm),
            SettingsTile(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Order updates & offers',
              iconColor: AppColors.primaryDark,
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('Support', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: AppSpacing.sm),
            SettingsTile(
              icon: Icons.help_outline_rounded,
              title: 'Help center',
              iconColor: AppColors.textBody,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            SettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy policy',
              iconColor: AppColors.textBody,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.lg),
            SettingsTile(
              icon: Icons.logout_rounded,
              title: 'Log out',
              iconColor: AppColors.danger,
              trailing: const SizedBox.shrink(),
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
