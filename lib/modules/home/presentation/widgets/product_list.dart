import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/config/routes/cubit/router_manager.dart';
import '../../../../core/utils/extension/extension.dart';

import '../../domain/entities/entities.dart';
import '../bloc/home/home_bloc.dart';
import '../view/detail/detail_view.dart';
import 'container_shimmer.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String heroTag = 'product';
    final products = context.watch<HomeBloc>().state.products;
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 5,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final ProductEntity product = products[index];
        return InkWell(
          onTap: () {
            context.read<RouterManager>().navigateProductDetails(
                  DetailView.path,
                  id: product.id,
                  heroTag: heroTag,
                );
          },
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).focusColor.withValues(alpha: 0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'ID: ${product.id ?? ''}',
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: '$heroTag${product.id}',
                      child: product.isNull
                          ? const ContainerShimmer(
                              height: 250,
                            )
                          : CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.contain,
                              height: 250,
                              width: double.infinity,
                              imageUrl: product.image ?? '',
                              placeholder: (context, url) =>
                                  const ContainerShimmer(
                                height: 250,
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 150,
                                color: Colors.grey.withValues(alpha: 0.5),
                                child: const Center(
                                  child: Icon(
                                    Icons.error,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        product.title?.toUpperCase() ?? '',
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        product.description ?? '',
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '${'price'.tr()}: US\$ ${product.price ?? 0}',
                      textAlign: TextAlign.right,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 20),
    );
  }
}
