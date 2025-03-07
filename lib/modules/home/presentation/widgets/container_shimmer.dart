import 'package:flutter/material.dart';
import '../../../../core/utils/extension/extension.dart';
import 'package:shimmer/shimmer.dart';

class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Center(
      child: Shimmer.fromColors(
        baseColor: colorScheme.secondary.withValues(alpha: 0.4),
        highlightColor: colorScheme.secondary.withValues(alpha: 0.6),
        child: Container(
          width: width ?? double.infinity,
          height: height,
          color: colorScheme.secondary.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
