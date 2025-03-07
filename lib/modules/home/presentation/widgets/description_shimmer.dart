import 'package:flutter/material.dart';

import 'container_shimmer.dart';

class ShimmerDescription extends StatelessWidget {
  const ShimmerDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerShimmer(
          height: 20,
          width: (width * 0.45),
        ),
        const SizedBox(height: 10),
        ContainerShimmer(
          height: 20,
          width: (width * 0.70),
        ),
        const SizedBox(height: 10),
        ContainerShimmer(
          height: 20,
          width: (width * 0.55),
        ),
        const SizedBox(height: 30),
        const ContainerShimmer(height: 20),
        const SizedBox(height: 10),
        const ContainerShimmer(height: 20),
        const SizedBox(height: 10),
        const ContainerShimmer(height: 20),
        const SizedBox(height: 10),
        const ContainerShimmer(height: 20),
      ],
    );
  }
}
