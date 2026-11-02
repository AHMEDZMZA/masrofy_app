import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../extensions/build_context.dart';
import '../themes/app_sizes.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.addNewItem});

  final String title;
  final VoidCallback? addNewItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: context.colorScheme.onSurface,
            size: AppSizes.iconM,
          ),
        ),
        Text(title, style: context.textTheme.titleLarge),
        IconButton(
          onPressed: addNewItem,
          icon: Icon(
            Icons.add_rounded,
            color: context.colorScheme.onSurface,
            size: AppSizes.iconM,
          ),
        ),
      ],
    );
  }
}
