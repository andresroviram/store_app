import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/utils/extension/extension.dart';

import '../../../../../core/const/constant.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../domain/usecases/home_usecases.dart';
import '../../../../../config/injectable/injectable_dependency.dart';
import '../../../../../config/routes/cubit/router_manager.dart';
import '../../bloc/detail/detail_bloc.dart';
import '../../widgets/container_shimmer.dart';
import '../../widgets/description_shimmer.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.heroTag, required this.id});
  final String heroTag;
  final String id;

  static const String path = '/product/:id';
  static const String name = 'product';

  static Widget create({required String id, String? heroTag}) => BlocProvider(
        lazy: false,
        create: (context) => DetailBloc(
          homeUseCase: getIt<HomeUseCase>(),
        )..add(DetailEvent.detail(id)),
        child: DetailView(heroTag: heroTag ?? 'product', id: id),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailBloc, DetailState>(
      listener: (context, state) {
        if (state.failure != null) {
          ShowFailure.instance.mapFailuresToNotification(
            context,
            failure: state.failure!,
          );
        }
      },
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (_, state) {
          return Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              centerTitle: true,
              title: Text('ID: ${state.product.id ?? '...'}'),
              automaticallyImplyLeading: false,
              leading: Constant.isWeb
                  ? null
                  : IconButton(
                      icon: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.primary,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      onPressed: () => context.read<RouterManager>().pop(),
                    ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: '$heroTag$id',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: state.product.isNull
                          ? const ContainerShimmer(
                              height: 300,
                              width: 230,
                            )
                          : CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.contain,
                              height: 300,
                              width: double.infinity,
                              imageUrl: state.product.image ?? '',
                              placeholder: (context, url) =>
                                  const ContainerShimmer(
                                height: 300,
                                width: 230,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: state.isLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ShimmerDescription(),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '${state.product.title}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                    context.colorScheme.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            if (state.product.category
                                                    ?.isNotEmpty ??
                                                false) ...[
                                              Text(
                                                state.product.category ?? '',
                                                textAlign: TextAlign.center,
                                                maxLines: 6,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          state.product.description ?? '',
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${'price'.tr()}: US\$ ${state.product.price ?? ''}',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: Helper.getStarsList(
                                                    state.product.rating
                                                            ?.rate ??
                                                        0,
                                                    size: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
