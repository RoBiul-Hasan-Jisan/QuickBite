import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavItemData({required this.icon, required this.activeIcon, required this.label});
}

const kNavItems = [
  NavItemData(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
  NavItemData(icon: Icons.search_rounded, activeIcon: Icons.search_rounded, label: 'Search'),
  NavItemData(
    icon: Icons.receipt_long_outlined,
    activeIcon: Icons.receipt_long_rounded,
    label: 'Orders',
  ),
  NavItemData(
    icon: Icons.favorite_border_rounded,
    activeIcon: Icons.favorite_rounded,
    label: 'Favorites',
  ),
  NavItemData(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, -6)),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(kNavItems.length, (index) {
              final item = kNavItems[index];
              final selected = index == currentIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primaryLight.withOpacity(0.5) : null,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selected ? item.activeIcon : item.icon,
                          size: 22,
                          color: selected ? AppColors.primaryDark : AppColors.textBody,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected ? AppColors.primaryDark : AppColors.textBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
